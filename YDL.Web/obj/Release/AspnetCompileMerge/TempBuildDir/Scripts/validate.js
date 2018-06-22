/// <reference path="../jquery-1.10.2.js" />
/// <reference path="../jquery-extend-1.0.js" />

//格式检查函数   
function isInteger(str) { return /^[-+]?[0-9]+$/.test(str); }
function isPhone(str) { return /^\+?((\d{2,4}(-)?)|(\(\d{2,4}\)))*(\d{0,16})*$/.test(str.replace(/\s/gi, '')); }
function isMobileNo(str) { return /^\+?\d{0,4}((013|015|018|13|15|18)\d{9}|(0189|0187|0186|189|187|186)|(0147|0170|147|170)\d{8})$/.test(str.replace(/\s/gi, '')); }
function isMultiPhone(str) { return /^(\d{2,6}-?)?\d{3,11}(-?\d{1,6})?(,(\d{2,6}-?)?\d{3,11}(-?\d{1,6})?)*$/.test(str); }
function isEmail(str) {
    str = str.toLowerCase();
    if (/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/.test(str)) {
        return true;
    } else {
        return /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/.test(str)
    }
}

function isUrl(str) {
    return /^((http|https|ftp):\/\/){0,1}((\w|-)+\.){1,3}(com|net|org|int|edu|gov|mil|arpa|biz|info|name|pro|coop|aero|museum|cc|tv|ad|ae|af|ag|ai|al|am|an|ao|aq|ar|as|at|au|aw|az|ba|bb|bd|be|bf|bg|bh|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cc|cf|cg|ch|ci|ck|cl|cm|cn|co|cq|cr|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|ee|eg|eh|es|et|ev|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gh|gi|gl|gm|gn|gp|gr|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|in|io|iq|ir|is|it|jm|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|mg|mh|ml|mm|mn|mo|mp|mq|mr|ms|mt|mv|mw|mx|my|mz|na|nc|ne|nf|ng|ni|nl|no|np|nr|nt|nu|nz|om|pa|pe|pf|pg|ph|pk|pl|pm|pn|pr|pt|pw|py|qa|re|ro|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sy|sz|tc|td|tf|tg|th|tj|tk|tm|tn|to|tp|tr|tt|tv|tw|tz|ua|ug|uk|us|uy|va|vc|ve|vg|vn|vu|wf|ws|ye|yu|za|zm|zr|zw){1,1}(\.cn|hk)?(\/)?\w*/i.test(str) ||
             /^((http|https|ftp):\/\/){0,1}([1-9]{1,2}|1\d{1,2}|2[0-4]?\d|25[0-5])\.((\d{1,2}|1\d{1,2}|2[0-4]?\d|25[0-5])\.){2}([0-9]{1,2}|1\d{1,2}|2[0-4]?\d|25[0-5]){1,1}(\:\d{1,4})?(\/\w*)*$/.test(str);
}
function isDecimal(str) { return /^[-+]?[0-9]+([.]?[0-9]+)?$/.test(str); }
function isIpAddress(str) { return /^([1-9]{1,2}|1\d{1,2}|2[0-4]?\d|25[0-5])\.((\d{1,2}|1\d{1,2}|2[0-4]?\d|25[0-5])\.){2}([0-9]{1,2}|1\d{1,2}|2[0-4]?\d|25[0-5])$/.test(str); }
function isDate(str) { return /^((\d{2}(([02468][048])|([13579][26]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|([1-2][0-9])))))|(\d{2}(([02468][1235679])|([13579][01345789]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))$/.test(str) }
function isDateTime(str) { return /^((\d{2}(([02468][048])|([13579][26]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|([1-2][0-9])))))|(\d{2}(([02468][1235679])|([13579][01345789]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\s(20|21|22|23|[0-1]?\d):[0-5]?\d(:[0-5]?\d)?)?$/.test(str) }
function isPost(str) { return /^[0-9]\d{5}(?!d)$/.test(str); }
function isCrmName(str) { return /^[a-z0-9\u2E80-\u9FFF_]+$/gi.test(str); }
function isIDCard(str) { return /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(str); }
function isQQ(str) { return /^\d{5,12}$/.test(str); }


$.ns('ydl.widgets');
ydl.widgets.Validate = (function ($, window, undefined) {

    var options = {};
    var formatType = {
        fixPhone: 'fixPhone',
        mobilePhone: 'mobilePhone',
        email: 'email',
        url: 'url',
        integer: 'integer',
        decimal: 'decimal',
        ipAddress: 'ipAddress',
        date: 'date',
        post: 'post',
        multiphone: 'multiphone',
        html: 'html',
        crmname: 'crmname',
        idCard: 'idCard',
        qq:'qq'
    };


    function _addValidate(cfg) {
        if (!$.isEmpty(cfg.target, false)) {
            var obj = $("#" + cfg.target);

            //缓存文本框的title属性，和错误提示框的HTML
            cfg.defaultTile = obj.attr("title");
            if (!$.isEmpty(cfg.errMsgElId, false))
                cfg.defaultMsg = $("#" + cfg.errMsgElId).html();

            if (cfg.mouseOutIsValidate !== false) {
                //IE:propertychange,非IE:input
                obj.bind('blur', cfg, _onValidate);

            }
            options[cfg.target] = cfg;

            //如果配置中包含maxlength设置就将其应用大文本框上
            if ($.isNumber(cfg.maxLength) && !$.isEmpty(cfg.target, false)) {
                $('#' + cfg.target).attr('maxlength', cfg.maxLength);
            }
        }
    }

    function _addValidates(cfgs) {
        if ($.isArray(cfgs)) {
            $.foreach_array(function (cfg) {
                _addValidate(cfg);
            }, cfgs);
        }
    }

    function _addRadioValidate(cfg) {
        if (!$.isEmpty(cfg.target, false)) {
            cfg.type = "radio";
            if (!$.isEmpty(cfg.errMsgElId, false))
                cfg.defaultMsg = $("#" + cfg.errMsgElId).html();
            $("input[name='" + cfg.target + "']").bind("click blur", cfg, _onValidate);
            options[cfg.target] = cfg;
        }
    }
    function _addCheckBoxValidate(cfg) {
        if (!$.isEmpty(cfg.target, false)) {
            cfg.type = "checkbox";
            if (!$.isEmpty(cfg.errMsgElId, false))
                cfg.defaultMsg = $("#" + cfg.errMsgElId).html();
            $("input[name='" + cfg.target + "']").bind("click blur", cfg, _onValidate);
            options[cfg.target] = cfg;
        }
    }
    function _cancelValidate(target) {

        if (!$.isObject(options[target])) return;
        $('#' + target).unbind('propertychange', _onValidate)
            .unbind('input', _onValidate)
            .removeClass("redborder red")
            .attr("title", $.isEmpty(options[target].defaultTitle, false) ? "" : options[target].defaultTitle);
        options[target] = null;
    }
    function _cancelValidates(targets) {

        if ($.isArray(targets)) {
            for (var i = 0; i < targets.length; i++) {
                _cancelValidate(targets[i]);
            }
        }
    }

    function _onValidate(evt) {
        _singleValidate(evt.data);

    }
    function _singleValidate(cfg) {

        var isOk = true, errMsg = "";
        if ($.isEmpty(cfg) || $.isEmpty(cfg.target)) return isOk;

        if ($.isObject(cfg)) {


            switch (cfg.type) {
                case "radio":
                    {
                        var checkAmount = 0, radios = $("input[name='" + cfg.target + "']");
                        radios.each(function (i, item) {
                            checkAmount += item.checked == true ? 1 : 0;
                        });

                        if (checkAmount == 0) {
                            isOk = false;
                            errMsg = cfg.emptyErrMsg;
                            radios.parent().addClass("redborder")
                        }
                        else
                            radios.parent().removeClass("redborder");
                        break;
                    }
                case "checkbox":
                    {
                        var checkAmount = 0, checks = $("input[name='" + cfg.target + "']");
                        checks.each(function (i, item) {
                            checkAmount += item.checked == true ? 1 : 0;
                        });

                        if (checkAmount > 0) {
                            if ($.isFunction(cfg.customerValidate))
                                isOk = cfg.customerValidate(cfg.target, checkAmount);
                        }
                        else
                            isOk = false;

                        if (!isOk) {
                            isOk = false;
                            errMsg = cfg.emptyErrMsg;
                            checks.parent().addClass("redborder")
                        }
                        else
                            checks.parent().removeClass("redborder");
                        break;
                    }
                default:
                    {

                        if (cfg.format == formatType.html && window[cfg.target]) {

                            if (cfg.allowEmpty === false && $.isEmpty(window[cfg.target].html(), false)) {
                                cfg.errMsg = cfg.emptyErrMsg;
                                return false
                            }

                            return true;
                        }

                        //获取元素的当前值
                        var element = $("#" + cfg.target);
                        if (element.length <= 0) {
                            return true;
                        }

                        var value = element.val() || element.attr('v') || element.html();
                        var isEmpty = $.isEmpty(value, false) || value == cfg.emptyText;
                        //检查是否允许空
                        if (cfg.allowEmpty === false && isEmpty) {
                            errMsg = cfg.emptyErrMsg;
                            isOk = false;

                        }

                        //格式验证
                        if (isOk && !isEmpty) {

                            switch (cfg.format) {
                                case formatType.integer: { isOk = isInteger(value); break; }
                                case formatType.decimal: { isOk = isDecimal(value); break; }
                                case formatType.fixPhone: { isOk = isPhone(value); break; }
                                case formatType.mobilePhone: { isOk = isMobileNo(value); break; }
                                case formatType.email: { isOk = isEmail(value); break; }
                                case formatType.url: { isOk = isUrl(value); break; }
                                case formatType.ipAddress: { isOk = isIpAddress(value); break; }
                                case formatType.date: { isOk = isDate(value) || isDateTime(value); break; }
                                case formatType.post: { isOk = isPost(value); break; }
                                case formatType.multiphone: { isOk = isMultiPhone(value); break; }
                                case formatType.crmname: { isOk = isCrmName(value); break; }
                                case formatType.idCard: { isOk = isIDCard(value); break; }
                                case formatType.qq: { isOk = isQQ(value); break; }
                                default: { break; }
                            }

                            errMsg = isOk ? "" : cfg.formatErrMsg;

                            //验证小数位数
                            if (cfg.format == formatType.decimal && isInteger(cfg.maxDigits) && cfg.maxDigits >= 0) {
                                var len = (value.replace(/^[-+]?[0-9]+/gi, '').replace(/^[.]+/gi, '')).length;
                                if (len > cfg.maxDigits) {
                                    isOk = false;
                                    errMsg = $.isEmpty(cfg.maxDigitsErrMsg, false) ? '' : cfg.maxDigitsErrMsg;
                                }
                            }

                            //如果格试为整数、小数则进行取值范围验证                
                            if ((isOk && (cfg.format == formatType.integer || cfg.format == formatType.decimal || cfg.format == formatType.date))) {
                                if (!(cfg.format == formatType.date)) {
                                    value = parseFloat(value);
                                }
                                var o = null;
                                if (!$.isEmpty(cfg.minValueEl, false)) {

                                    o = $('#' + cfg.minValueEl);
                                    if (o.length > 0) {
                                        if (!(cfg.format == formatType.date)) {
                                            cfg.minValue = parseFloat(o.val());
                                        }
                                        else {
                                            cfg.minValue = o.val();
                                        }
                                    }
                                }
                                if (!$.isEmpty(cfg.maxValueEl, false)) {
                                    o = $('#' + cfg.maxValueEl);
                                    if (o.length > 0) {
                                        if (!(cfg.format == formatType.date)) {
                                            cfg.minValue = parseFloat(o.val());
                                        }
                                        else {
                                            cfg.minValue = o.val();
                                        }
                                    }
                                }
                                o = null;

                                if (((cfg.format == formatType.decimal || cfg.format == formatType.integer) && (isDecimal(cfg.minValue) && value < cfg.minValue) || (isDecimal(cfg.maxValue) && value > cfg.maxValue))
                                    || (cfg.format == formatType.date && ((isDate(cfg.minValue) && new Date(value.replace(/-/gi, '/')) < new Date(cfg.minValue.replace(/-/gi, '/'))) || (isDate(cfg.maxValue) && new Date(value.replace(/-/gi, '/')) > new Date(cfg.maxValue.replace(/-/gi, '/')))
                                    || (isDateTime(cfg.minValue) && value < cfg.minValue) || (isDateTime(cfg.maxValue) && value > cfg.maxValue)))) {
                                    isOk = false;
                                    errMsg = cfg.valueErrMsg;
                                }
                            }

                        }

                        //长度验证
                        if (isOk && ((isInteger(cfg.minLength) && cfg.minLength > value.length) || (isInteger(cfg.maxLength) && cfg.maxLength < value.length))) {
                            isOk = false;
                            errMsg = cfg.lengthErrMsg;
                        }

                        if (isOk && $.isFunction(cfg.customerValidate)) {
                            isOk = cfg.customerValidate(cfg.target, cfg);
                            errMsg = cfg.customerErrMsg;
                        }

                        //呈现在文本框上的出错消息通知

                        element = cfg.isComBox ? $('#' + cfg.controlId) : ($.isEmpty(cfg.notifyPanel, false) ? element : $('#' + cfg.notifyPanel));
                        if (!isOk) {
                            element.attr("title", errMsg).addClass("redborder red");
                            if (ydl.widgets.Validate.setBackground == true) {
                                element.oldBack = element.css('background-color');
                                element.css('background-color', 'red')
                            }
                        }
                        else {
                            element.removeClass("redborder red")
                                    .attr("title", $.isEmpty(cfg.defaultTitle, false) ? "" : cfg.defaultTitle);

                            if (ydl.widgets.Validate.setBackground == true) {
                                element.css('background-color', $.isEmpty(element.oldBack, false) ? '' : element.oldBack);
                            }

                        }

                        element = null;

                        break;
                    }
            }

            //呈现在指定元素上的错误消息通知
            var errNotifyEl = $("#" + cfg.errMsgElId);
            if (errNotifyEl.length > 0) {
                if (!isOk) {
                    errNotifyEl.addClass("red");
                    errNotifyEl.html(errMsg);
                }
                else {
                    errNotifyEl.removeClass("red");
                    errNotifyEl.html(cfg.defaultMsg);
                }
            }
            errNotifyEl = null;
        }
        cfg.errMsg = errMsg;
        return isOk;
    }

    function _formValidate(formId) {
        var errAmount = 0, firstOpt = null;
        if ($.isEmpty(formId, false)) {
            for (var target in options) {
                if (!_singleValidate(options[target])) {
                    errAmount++;
                    firstOpt = firstOpt == null ? options[target] : firstOpt;
                }
            }
        } else {
            var els;
            for (var target in options) {
                opt = options[target];
                if (opt.type == 'checkbox' || opt.type == 'radio')
                    els = $('#' + formId + ' input[name="' + target + '"]');
                else
                    els = $("#" + formId + " #" + target);

                if (els.length > 0 && !_singleValidate(opt)) {
                    errAmount++;
                    firstOpt = firstOpt == null ? opt : firstOpt;
                }
            }
        }
        if (errAmount > 0) {
            if (firstOpt != null) {
                if (top.errorBox) {
                    top.errorBox(firstOpt.errMsg || firstOpt.customerErrMsg, function (el) { $('#' + el).focus(); }, [firstOpt.target]);
                } else {
                    alert(firstOpt.errMsg);
                    $('#' + firstOpt.target).focus();
                }

            }

            //clear
            errAmount = null;
            firstOpt = null;

            return false;

        } else {

            //clear
            errAmount = null;
            firstOpt = null;

            return true;

        }
    }

    return {
        format: formatType,
        addValidate: _addValidate,
        addValidates: _addValidates,
        addRadioValidate: _addRadioValidate,
        addCheckBoxValidate: _addCheckBoxValidate,
        cancelValidate: _cancelValidate,
        cancelValidates: _cancelValidates,
        formValidate: _formValidate,
        validateAll: function () {
            return _formValidate(null)
        },
        singleValidate: function (target) {
            if ($.isEmpty(target, false)) return true;
            return _singleValidate(options[target]);
        }

    };

})(jQuery, window);
