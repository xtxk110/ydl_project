/// <reference path="jquery/jquery-1.10.2.min.js" />
/// <reference path="jquery/jquery-crmextend-1.0.js" />

_global_zindex = 10000;

$.mark_cfg = {id: ''}

/*遮罩组件*/
if (typeof (MarkManagers) == "undefined") MarkManagers = {
    instance: {},
    amount: 0
};


$.fn.mark = function (cfg) {

    var html = [];
    return this.each(function (i, o, me, _cfg) {

        _cfg = $.extend({}, $.mark_cfg, cfg || {});
        me = $(this);
        if ($.isEmpty(_cfg.id, false)) _cfg.id = 'mark_' + MarkManagers.amount;


        var p = {
            init: function () {
                html.length = 0;
                html.push('<div class="mark" id="', _cfg.id, '" onselectstart="return false"></div>');
                p.owner.append(html.join(''));

                _global_zindex++
                $('#' + _cfg.id).css('z-index', _global_zindex);

                p.autoSize();
                $(window).resize(p.autoSize);


            },
            autoSize: function () {
                var o = $('#' + _cfg.id), w = $(window);
                var height = p.owner.is('body') ? w.height() : p.owner.height();
                o.css({'height': height + 'px'});

            }
        };
        var g = {
            close: function () {
                //解除事件绑定
                $(window).unbind('scroll', p.autoSize)
                          .unbind('resize', p.autoSize);
                //删除对象
                MarkManagers.instance[_cfg.id] = null;
                MarkManagers.amount--;
                delete MarkManagers.instance[_cfg.id];
                //删除元素
                var mark = $('#' + _cfg.id);
                if (mark.css('z-index') == _global_zindex) {
                    _global_zindex--;
                }
                mark.remove();
            }
        };


        p.owner = me;
        p.init();

        MarkManagers.instance[_cfg.id] = g;
        MarkManagers.amount++;

    });

}



$.diag_cfg = {
    id: '',
    url: undefined,
    title: '',
    width: 600,
    height: 480,
    owner: window,
    args: undefined,
    callback: undefined
}

if (typeof (DialogManagers) == "undefined") DialogManagers = {
    instance: {},
    amount: 0,
    scrolling: false
};

$.fn.dialog = function (cfg) {
    var html = [], w = $(window);

    return this.each(function (i, o, me, _cfg, id) {

        _cfg = $.extend({}, $.diag_cfg, cfg || {});
        _cfg.id = $.isEmpty(_cfg.id, false) ? 'diag_' + DialogManagers.amount : _cfg.id;
        _cfg.id = i > 0 ? (_cfg.id + '_' + i) : _cfg.id;
        if (!$.isEmpty(_cfg.url, false)) {
            _cfg.url = _cfg.url + (_cfg.url.indexOf('?') > -1 ? '&' : '?') + 'diag=' + _cfg.id
        } else {
            _cfg.url = 'about:blank';
        }
        me = $(this);
        html.length = 0;
        html.push('<div class="ui-widget-dialog" id="', _cfg.id, '" onselectstart="return false">');
        html.push('<div class="ui-widget-dialog-title" id="', _cfg.id, '_title">', _cfg.title, '<div class="ui-widget-dialog-titlebtns"><input type="button" class="button close vmd"/></div></div>');
        html.push('<div class="ui-widget-dialog-contentarea" id="', _cfg.id, '_content"><iframe id="', _cfg.id, '_frame" src="', _cfg.url, '" frameborder="0" ', (_cfg.scrolling ? '' : 'scrolling="no"'), ' width="100%" allowtransparency="true"></iframe></div>');
        html.push('</div>');

        var p = {
            init: function () {

                me.append(html.join(''));
                var w = $(window);
                if (_cfg.width < 0) { _cfg.width = $.diag_cfg.width; }
                if (_cfg.height < 0) { _cfg.height = $.diag_cfg.height; }
                if (_cfg.height > w.height()) { _cfg.height -= (_cfg.height - w.height() - 15); }
                var dig = $('#' + _cfg.id),
                    ww = w.width() / 2,
                    wh = w.height() / 2,
                    markid = _cfg.id + '_mark';

                //显示遮罩
                p.parent.mark({ id: markid });

                _global_zindex++
                var top = wh - _cfg.height / 2;
                top = top < 0 ? 10 : top;
                dig.css({
                    'width': _cfg.width + 'px',
                    'height': _cfg.height + 'px',
                    'left': (ww - _cfg.width / 2) + 'px',
                    'top': top + 'px',
                    'z-index': _global_zindex
                })
                .click(p.click)
                .mousedown(p.mousedown)
                .mouseup(p.mouseup)
                dig.find('iframe').first().focus();
                $('#' + _cfg.id + '_content,#' + _cfg.id + '_frame').height(_cfg.height - 36);
                p.dialog = dig;

            }, click: function (e) {
                var o = $(e.target);
                if (o.hasClass('close')) {
                    p.close();
                }
            },
            mousedown: function (e) {
                var o = $(e.target);
                var win = $(window);

                if (o.hasClass('ui-widget-dialog-title')) {
                    var offset = p.dialog.offset();
                    p.mx = e.pageX;
                    p.my = e.pageY;
                    p.stop = win.scrollTop();
                    p.sleft = win.scrollLeft();
                    p.dx = offset.left;
                    p.dy = offset.top;
                    $(document.body).css({ 'cursor': 'move' })
                                    .mousemove(p.mousemove);
                }

            },
            mousemove: function (e) {
                p.dialog.css({
                    left: p.dx + (e.pageX - p.mx - p.sleft) + 'px',
                    top: p.dy + (e.pageY - p.my - p.stop) + 'px'
                });
                return false;
            },
            mouseup: function () {

                $(document.body).unbind('mousemove', p.mousemove)
                                .css({ 'cursor': 'default' });

            },
            close: function () {

                clearTimeout(p.colosetimer);
                DialogManagers.instance[_cfg.id] = null;
                delete DialogManagers.instance[_cfg.id];
                DialogManagers.amount--;
                if (p.dialog.css('z-index') == _global_zindex) {
                    _global_zindex--;
                }

                try {
                    //先删除flash上传组件，否则ie9++会报错
                    var subwin = $('#' + _cfg.id + '_frame')[0].contentWindow;
                    if (subwin.AnnexManagers) {
                        for (var annex in subwin.AnnexManagers) {

                            if (subwin.AnnexManagers[annex] && subwin.AnnexManagers[annex].destroy) subwin.AnnexManagers[annex].destroy();
                        }
                    }

                } catch (e) { }



                p.dialog.remove();
                MarkManagers.instance[_cfg.id + '_mark'].close();

            }
        };
        var g = {
            close: function (iscallback, args) {
                if (iscallback) {
                    g.callBack(args);
                }

                p.colosetimer = setTimeout(p.close, 100);
            },
            getArgs: function () {
                return _cfg.args;
            },
            callBack: function (args) {
                if ($.isFunction(_cfg.callback)) {
                    _cfg.callback.apply(_cfg.owner, $.isArray(args) ? args : []);
                } else if (typeof (_cfg.callback) == 'string') {
                    _cfg.owner[_cfg.callback].apply(_cfg.owner, $.isArray(args) ? args : []);
                }
            }
        };

        p.parent = me;
        p.init();
        DialogManagers.instance[_cfg.id] = g;
        DialogManagers.amount++;

    });
}


function openDialog(cfg) {
    $(document.body).dialog(cfg);
}

function closeDiag(wind, iscallback, args) {
    var diag = $.urlParam('diag', wind.location.search);
    if (!$.isEmpty(diag, false));
    DialogManagers.instance[diag].close(iscallback, args);
}

function diagCallBack(wind,args) {
    var diag = $.urlParam('diag', wind.location.search);
    if (!$.isEmpty(diag, false));
    DialogManagers.instance[diag].callBack(args);
}

function getDiagArgs(wind) {
    var diag = $.urlParam('diag', wind.location.search);
    if (!$.isEmpty(diag, false));
    return DialogManagers.instance[diag].getArgs();
}


$.msgBtnType = { OK: 1, OkAndCancel: 2, Yes: 3, YesAndNo: 4 }

$.msg_cfg = {
    id: '',
    title: '',
    msg: '',
    btntype: $.msgBtnType.OK,
    width: 300,
    owner: window,
    btn1click: undefined,
    btn1click_agrs: [],
    btn2click: undefined,
    btn2click_agrs: []
}

if (typeof (MsgBoxManagers) == "undefined") MsgBoxManagers = {
    instance: {},
    amount: 0
};


$.fn.msgBox = function (cfg) {
    var html = [], w = $(window);
    return this.each(function (i, o, me, _cfg, id) {

        _cfg = $.extend({}, $.msg_cfg, cfg || {});
        _cfg.id = $.isEmpty(_cfg.id, false) ? 'msbox_' + MsgBoxManagers.amount : _cfg.id;
        _cfg.id = i > 0 ? (_cfg.id + '_' + i) : _cfg.id;
        me = $(this);
        html.length = 0;
        html.push('<div class="ui-widget-dialog" id="', _cfg.id, '" onselectstart="return false">');
        html.push('<div class="ui-widget-dialog-title">', _cfg.title, '<div class="ui-widget-dialog-titlebtns"><input type="button" class="button close" /></div></div>');
        html.push('<div class="ui-widget-dialog-contentarea" id="', _cfg.id, '_content"><div class="ui-widget-dialog-msg">', _cfg.msg, '</div>');
        html.push('<div class="ui-widget-dialog-btnbar" id="', _cfg.id, '_btnbar">');
        if (_cfg.btntype == $.msgBtnType.OK) {
            html.push('<input type="button" value="确定" extvalue="ok" id="', _cfg.id, '_ok" class="ui-widget-dialog_btn"/>');
        } else if (_cfg.btntype == $.msgBtnType.OkAndCancel) {
            html.push('<input type="button" value="确定" extvalue="ok" id="', _cfg.id, '_ok" class="ui-widget-dialog_btn"/>');
            html.push('&nbsp;&nbsp;<input type="button" value="取消" extvalue="cancnel" id="', _cfg.id, '_cacel" class="ui-widget-dialog_btn"/>');
        } else if (_cfg.btntype == $.msgBtnType.Yes) {
            html.push('<input type="button" value="是" id="', _cfg.id, '_yes" extvalue="yes" class="ui-widget-dialog_btn"/>');
        }
        else if (_cfg.btntype == $.msgBtnType.YesAndNo) {
            html.push('<input type="button" value="是" id="', _cfg.id, '_yes" extvalue="yes" class="ui-widget-dialog_btn"/>');
            html.push('&nbsp;&nbsp;<input type="button" value="否" id="', _cfg.id, '_no" extvalue="no" class="ui-widget-dialog_btn"/>');
        }
        html.push('</div>')
        html.push('</div>');
        html.push('</div>');


        var p = {
            init: function () {
                me.append(html.join(''));
                var dig = $('#' + _cfg.id);

                if (_cfg.width < 0) { _cfg.width = $.diag_cfg.width; }
                _cfg.height = dig.height();

                var ww = w.width() / 2,
                    wh = w.height() / 2,
                    markid = _cfg.id + '_mark';

                //显示遮罩
                p.parent.mark({ id: markid });
                _global_zindex++

                dig.css({
                    'width': _cfg.width + 'px',
                    'left': (ww - _cfg.width / 2) + 'px',
                    'top': (wh - _cfg.height / 2) + 'px',
                    'z-index': _global_zindex
                })
                .click(p.click)
                .mousedown(p.mousedown)
                .mouseup(p.mouseup)
                setTimeout(function () { dig.find('input').last().focus(); }, 200);


                p.dialog = dig;

            }, click: function (e) {
                var o = $(e.target);
                if (o.hasClass('close')) {
                    p.close();
                } else if (o.hasClass('ui-widget-dialog_btn')) {

                    switch (o.attr('extvalue')) {
                        case 'ok':
                        case 'yes':
                            {
                                if ($.isFunction(_cfg.btn1click))
                                    _cfg.btn1click.apply(window, $.isArray(_cfg.btn1click_agrs) ? _cfg.btn1click_agrs : []);
                                break;
                            }
                        case 'cancel':
                        case 'no':
                            {
                                if ($.isFunction(_cfg.btn2click))
                                    _cfg.btn2click.apply(window, $.isArray(_cfg.btn2click_agrs) ? _cfg.btn2click_agrs : []);
                                break;
                            }
                    }
                    p.close();
                }
            },
            mousedown: function (e) {
                var o = $(e.target);

                if (o.hasClass('ui-widget-dialog-title')) {
                    var win = $(window);
                    var offset = p.dialog.offset();
                    p.mx = e.pageX;
                    p.my = e.pageY;
                    p.stop = win.scrollTop();
                    p.sleft = win.scrollLeft();
                    p.dx = offset.left;
                    p.dy = offset.top;
                    $(document.body).css({ 'cursor': 'move' })
                                    .mousemove(p.mousemove);
                }

            },
            mousemove: function (e) {
                p.dialog.css({
                    left: p.dx + (e.pageX - p.mx - p.sleft) + 'px',
                    top: p.dy + (e.pageY - p.my - p.stop) + 'px'
                });
                return false;
            },
            mouseup: function () {

                $(document.body).unbind('mousemove', p.mousemove)
                                .css({ 'cursor': 'default' });

            },
            close: function () {

                MsgBoxManagers.instance[_cfg.id] = null;
                delete MsgBoxManagers.instance[_cfg.id];
                MsgBoxManagers.amount--;
                if (p.dialog.css('z-index') == _global_zindex) {
                    _global_zindex--;
                }

                p.dialog.remove();
                MarkManagers.instance[_cfg.id + '_mark'].close();

            }
        };
        var g = {
            close: function () {
                p.close();
            }
        };

        p.parent = me;
        p.init();
        MsgBoxManagers.instance[_cfg.id] = g;
        MsgBoxManagers.amount++;


    });


}


errorBox = function (msg, ok_callback, ok_callback_args) {

    return $(document.body).msgBox({ title: '错误', msg: msg, btn1click: ok_callback, btn1click_agrs: ok_callback_args });
}

successBox = function (msg, ok_callback, ok_callback_args) {

    return $(document.body).msgBox({ title: '成功', msg: msg, btn1click: ok_callback, btn1click_agrs: ok_callback_args });
}

confirmBox = function (msg, yes_callback, yes_callback_args, no_callback, no_callback_args) {

    return $(document.body).msgBox({
        title: '询问',
        msg: msg,
        btntype: $.msgBtnType.YesAndNo,
        btn1click: yes_callback,
        btn1click_agrs: yes_callback_args,
        btn2click: no_callback,
        btn2click_agrs: no_callback_args
    });
}


if (typeof (WaitBoxManager) == "undefined") WaitBoxManager = { instance: null };

$.fn.waitBox = function (msg) {
    if (WaitBoxManager.instance == null) {

        var id = "waitbox", me = $(this);
        me.mark({ id: id + "_mark" });
        me.append('<div class="waitbox" id="' + id + '">' + msg + '</div>');
        _global_zindex++;
        var wind = $(window);
        var top = wind.height() / 2 + wind.scrollTop();
        $('#' + id).css({
            'z-Index': _global_zindex,
            'top': top + 'px'
        }).focus();

        var g = {

            close: function () {
                $('#' + id).remove();
                MarkManagers.instance[id + '_mark'].close();
                WaitBoxManager.instance = null;

            }
        }

        WaitBoxManager.instance = g;
    }
}


function openWaitBox(msg) {
    $(document.body).waitBox(msg);
}

function closeWaitBox() {
    WaitBoxManager.instance.close();
}

