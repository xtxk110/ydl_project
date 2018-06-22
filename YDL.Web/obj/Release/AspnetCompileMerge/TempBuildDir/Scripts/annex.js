/// <reference path="jquery-1.10.2.min.js" />
/// <reference path="jquery-crmextend-1.0.js" />
/// <reference path="swfobject.js" />
/// <reference path="swfupload.js" />

$.annexDefault = $.annexDefault || {
    type: 1,
    fileamount: 0,
    button_padding_left: 0,
    button_padding_top: 0,
    button_text: '',
    button_style: '',
    button_image_url: '',
    button_width: '100%',
    button_height: '100%',
    fileSelect: undefined,
    uploadSuccess: undefined,
    uploadComplete: undefined,
    isTemp: true,
    filetypes: null
}

if (typeof (AnnexManagers) == "undefined") AnnexManagers = {};
$.fn.getAnnex = function () {
    if (this.length > 0)
        return AnnexManagers[this[0].id];
    else
        return null;
};

$.fn.annex = function (cfg) {
    return this.each(function () {
        cfg = $.extend({}, $.annexDefault, cfg || {});

        var p = {
            box: $(this),
            waitFiles: [],
            errorFiles: [],
            initFileUpload: function () {
                var flashVer = swfobject.getFlashPlayerVersion();
                if (flashVer === undefined || flashVer.major < 9) {
                    p.box.html('缺少上传组件，<a href="http://get.adobe.com/cn/flashplayer/" target="_blank">去下载</a>。')
                    return;
                }
                if ($.isEmpty(cfg.filetypes, false)) {
                    cfg.filetypes = (cfg.type == 2 ? '*.' + globalConfig.allowFiles.replace(/,/gi, ';*.') : '*.png;*.jpg;*.gif;*.bmp');
                }
                var btnHolder = p.box.attr('id') + '_Holder';
                var settings = {

                    //URL设置
                    upload_url: convertUrl('~/Handlers/AnnexUploadHandler.ashx'),
                    flash_url: convertUrl('~/Handlers/UploadFlash.ashx'),
                    //附加的POST参数
                    post_params: {
                        "ASPSESSID": globalConfig.sid,
                        imgCompressWidth: $.urlParam('imgCompressWidth'),
                        imgCompressHeight: $.urlParam('imgCompressHeight'),
                        isTemp: cfg.isTemp
                    },

                    //文件过滤
                    file_types: cfg.filetypes,
                    file_types_description: (cfg.type == 2 ? "附件" : "图片"),
                    file_size_limit: globalConfig.fileMaxSize,
                    file_queue_limit: 0,

                    //关闭调试
                    debug: false,
                    //按钮设置
                    button_width: cfg.button_width,
                    button_height: cfg.button_height,
                    button_cursor: SWFUpload.CURSOR.HAND,
                    button_image_url: cfg.button_image_url,
                    button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
                    button_placeholder_id: btnHolder,
                    button_text: cfg.button_text,
                    button_text_left_padding: cfg.button_padding_left,
                    button_text_top_padding: cfg.button_padding_top,
                    button_text_style: cfg.button_style,

                    //事件
                    file_queued_handler: p.fileQueued,
                    file_queue_error_handler: p.fileQueueError,
                    file_dialog_start_handler: p.fileDialogStart,
                    file_dialog_complete_handler: p.fileDialogComplete,
                    upload_start_handler: p.uploadStart,
                    upload_progress_handler: p.uploadProgress,
                    upload_error_handler: p.uploadError,
                    upload_success_handler: p.uploadSuccess,
                    upload_complete_handler: p.uploadComplete

                };

                //上传个数限制
                if (cfg.fileamount == 1) {
                    settings.button_action = SWFUpload.BUTTON_ACTION.SELECT_FILE;

                } else {
                    settings.file_upload_limit = cfg.fileamount;
                    settings.button_action = SWFUpload.BUTTON_ACTION.SELECT_FILES;
                }

                p.box.append('<span id="' + btnHolder + '"></span>');
                p.swfup = new SWFUpload(settings);

            },
            /*文件选择框弹开之前*/
            fileDialogStart: function () {
                p.waitFiles.length = 0;
                p.errorFiles.length = 0;
            },
            fileQueued: function (file) {
                p.waitFiles.push(file);
            },
            fileQueueError: function (file, errorCode, message) {

                if (errorCode === SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
                    top.errorBox('选择的文件数量超出大小限制，最多可同时选择' + fileamount + '个文件。');
                } else {
                    failedFiles.push(file);
                    failedFiles.push(errorCode);
                    failedFiles.push(message);
                }
            },
            fileDialogComplete: function (selectedNumber, queuedNumber) {
                if (selectedNumber == 0) return;

                //显示出错的文件
                var errlen = p.errorFiles.length;
                if (errlen > 0) {

                    var buf = [];
                    for (var i = 0; i < errlen; i += 3) {
                        buf.push("文件:“", p.errorFiles[i].name, "” 出错。(原因:", errorCodeToString(p.errorFiles[i + 1]), ")<br/>");
                    }
                    if (buf.length > 0) {
                        top.errorBox(buf.join(''));
                    }
                    p.errorFiles.length = 0;
                }


                if (p.waitFiles.length > 0) {
                    if ($.isFunction(cfg.fileSelect)) {
                        cfg.fileSelect(p.waitFiles);
                    }

                    p.beginUpload();
                }

            },
            uploadStart: function (file) {

            },
            uploadProgress: function (file, bytescomplete, totalbytes) {
                var p = bytescomplete / totalbytes;
                var pi = Math.round(p * 100);
                $('#file' + file.id + 'pi').html('已上传 ' + pi + '%');
            },
            uploadError: function (file, errorCode, message) {
                $('#file' + file.id + 'pi').html(errorCodeToString(errorCode));
            },
            uploadSuccess: function (file, serverdata) {
                if ($.isFunction(cfg.uploadSuccess)) {
                    cfg.uploadSuccess({
                        id: file.id,
                        name: file.name,
                        size: file.size,
                        url: serverdata
                    });
                }
            },
            uploadComplete: function (file) {

                if (p.waitFiles[p.waitFiles.length - 1].id != file.id) {
                    this.startUpload();
                }
            },
            beginUpload: function () {

                if (p.swfup) {
                    var uploadCompleted = true;
                    $.foreach_array(function (f) {
                        if (f.isUploadOk !== true) {
                            uploadCompleted = false;
                            return true; //break
                        }
                    }, p.waitFiles);

                    if (!uploadCompleted) {
                        p.swfup.startUpload();
                        return true;
                    }
                }

                return false;

            }
        }
        g = {
            openFileDiag: function () {
                $('#' + p.swfup.movieName).trigger('click')
            }, destroy: function () {
                if (p.swfup && p.swfup.destroy) {
                    p.swfup.destroy();
                    p.swfup = null;
                }
                AnnexManagers[p.box.attr('id')] = null;
            }
        }
        p.initFileUpload();
        AnnexManagers[$(this).attr('id')] = g;
    });
}

function errorCodeToString(code) {
    switch (code) {
        case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT: return "文件尺寸超出大小限制";
        case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE: return "不能选择0字节文件";
        case SWFUpload.UPLOAD_ERROR.HTTP_ERROR: return "HTTP错误";
        case SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL: return "上传文件URL不正确";
        case SWFUpload.UPLOAD_ERROR.IO_ERROR: return "IO错误";
        case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR: return "安全错误";
        case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED: return "上传被限制";
        case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED: return "上传失败";
        case SWFUpload.UPLOAD_ERROR.SPECIFIED_FILE_ID_NOT_FOUND: return "文件未找到";
        case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED: return "文件验证失败";
        case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED: return "上传被取消";
        case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED: return "上传被停止";
    }
    return "";
}

function getFileSize(size) {
    size = size || 0;

    if (size < 1024)
        return size + 'byte';
    var tmp = size / 1024;
    if (tmp < 1024)
        return Math.round(tmp, 2) + 'KB';
    tmp = tmp / 1024;
    if (tmp < 1024)
        return Math.round(tmp, 2) + "MB";
    tmp = tmp / 1024;
    if (tmp < 1024) {
        return Math.round(tmp, 2) + "GB";
    }
    tmp = tmp / 1024;
    if (tmp < 1024)
        return Math.round(tmp, 2) + "TB";
}
