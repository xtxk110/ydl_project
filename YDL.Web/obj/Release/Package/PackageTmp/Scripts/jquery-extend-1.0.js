/// <reference path="jquery-1.10.2.min.js" />

(function ($, window, undefined) {

    var document = window.document;
    var ua = navigator.userAgent.toLowerCase();
    //alert(ua)
    var checkua = function (r) {
        switch (typeof r) {
            case 'object':
            case 'function':
                return r.test(ua);
            case 'string':
                return ua.indexOf(r) != -1;
            default:
                return false;
        }
    };

    $.extend($, (function () {

        var _escapeRegex = /([-.*+?^${}()|[\]\/\\])/g;
        var _decodeDateRegex = /^(\d{1,4})-(\d{1,2})-(\d{1,2})(?:T(\d{1,2})\:(\d{1,2})\:(\d{1,2})(?:\:(\d+))?)?/i;
        var ext_each = function (array, fn, scope) {//Ext中的each函数，因为和jquery有冲突，所以以内部函数方式使用
            if ($.isEmpty(array, false)) {
                return;
            }
            if (!$.isIterable(array) || $.isPrimitive(array)) {
                array = [array];
            }
            for (var i = 0, len = array.length; i < len; i++) {
                if (fn.call(scope || array[i], array[i], i, array) === false) {
                    return i;
                }
            }
        };

        return {
            getLinkId: function (s) {
                if (!$.isEmpty(s, false))
                {
                    return s.split(",")[0];
                }
                return '';
            },
            getLinkName: function (s) {
                if (!$.isEmpty(s, false)) {
                    var arr = s.split(",");
                    return arr.length == 1 ? arr[0] : (s.replace(arr[0] + ",", ""));
                }
                return '';
            },
            emptyFn: function () { },
            emptyString: '',
            returnFalse: function () { return false; },
            fileSize: function (size) {//文件尺寸运算
                if (typeof size == 'string') {
                    size = parseInt(size, 10);
                }
                if (size < 1024) {
                    return size + 'byte';
                }
                size = size / 1024;
                if (size < 1024) {
                    return Math.formatNumber(size, 2) + 'KB';
                }
                size = size / 1024;
                if (size < 1024) {
                    return Math.formatNumber(size, 2) + 'MB';
                }
                size = size / 1024;
                if (size < 1024) {
                    return Math.formatNumber(size, 2) + 'GB';
                }
            },
            override: function () {//扩展一个对象的原型对象
                if (arguments.length <= 1) {
                    return;
                } else {
                    arguments[0] = arguments[0].prototype;
                    $.extend.apply(arguments[0] || window, arguments);
                }
            },
            apply: function (o, c, defaults, excludes) {//复制一个对象的属性到另一个对象，直接覆盖已存在的
                if (defaults) {
                    o = $.apply(o, defaults);
                }
                if (o && c && $.isObject(c)) {
                    for (var p in c) {

                        if (typeof excludes === 'undefined' || typeof excludes[p] === 'undefined') {
                            o[p] = c[p];
                        }

                    }
                }
                return o;
            },
            applyIf: function (o, c) {//复制一个对象的属性到另一个对象，排除已存在的
                if (o) {
                    for (var p in c) {
                        if (!$.isDefined(o[p])) {
                            o[p] = c[p];
                        }
                    }
                }
                return o;
            },
            copyArray: function (src, dest) {


                if (!dest || typeof dest.length == 'undefined') {
                    return src;
                }
                if (!src) {
                    src = [];
                } else if (!$.isArray(src)) {
                    return src;
                }

                if ($.isArray(dest)) {
                    //直接拷贝数组
                    Array.prototype.push.apply(src, dest);

                } else {
                    //copy 带索引的对象
                    for (var i = 0, len = dest.length; i < len; i++) {
                        src.push(dest[i]);
                    }
                }
                return src;


            },
            removeNode: (function () {

                var timer;

                return function (el) {

                    if (el == null || el == undefined)
                        return;

                    if (document.body.removeNode) {

                        if (timer) {
                            clearTimeout(timer);
                            timer = null;
                        }

                        if (typeof el === 'string')
                            el = document.getElementById(el);

                        if (el) {

                            //移除下面的所有iframe元素
                            var ifms = el.getElementsByTagName('iframe');
                            if (ifms.length > 0) {
                                for (var i = 0, len = ifms.length, isIE10 = $.browser.ie10; i < len; i++) {

                                    //有多个iframe时要出错
                                    //                                    if (isIE10)
                                    //                                        ifms.item(i).removeNode(true);
                                    //                                    else
                                    //                                        ifms[i].removeNode(true);

                                    if (isIE10)
                                        ifms.item(0).removeNode(true);
                                    else
                                        ifms[0].removeNode(true);
                                }
                            }

                            //移除本元素
                            el.removeNode(true);

                            ifms = null;
                            el = null;

                            if (CollectGarbage) {
                                timer = setTimeout(CollectGarbage, 1000);
                            }

                        }


                    } else {

                        if (typeof el != 'string')
                            el = el.id;
                        if (!$.isEmpty(el, false))
                            $('#' + el).remove();
                    }


                }

            })(),
            ns: function () {
                var o, d;
                ext_each(arguments, function (v) {
                    d = v.split(".");
                    o = window[d[0]] = window[d[0]] || {};
                    ext_each(d.slice(1), function (v2) {
                        o = o[v2] = o[v2] || {};
                    });
                });

                d = null;

                return o;
            },
            iterate: function (obj, fn, scope) {
                if ($.isEmpty(obj)) {
                    return;
                }
                if ($.isIterable(obj)) {
                    ext_each(obj, fn, scope);
                    return;
                } else if ($.isObject(obj)) {
                    for (var prop in obj) {
                        if (obj.hasOwnProperty(prop)) {
                            if (fn.call(scope || obj, prop, obj[prop], obj) === false) {
                                return;
                            }
                        }
                    }
                }
            },
            filterArray: function (arr, filter, isAll) {

                if ($.isEmpty(arr) || !$.isArray(arr)) {
                    return [];
                }

                if ($.isFunction(filter)) {

                    var re = [], i = 0, len = arr.length, item;
                    for (; i < len; i += 1) {
                        item = arr[i];
                        if (filter(item)) {
                            re.push(item);
                        }
                    }
                    return re;

                } else if ($.isNumber(filter)) {
                    return (filter >= 0 && filter < len) ? [arr[filter]] : [];
                }

                return isAll === true ? arr : [];

            },
            foreach_array: function (fn, arr, context, args) {

                if (!$.isFunction(fn) || arr === null || arr === undefined || typeof arr.length === 'undefined') {
                    return;
                }

                if ($.isEmpty(args)) {
                    args = [];
                } else {
                    if (!$.isArray(args)) {
                        args = [args];
                    }
                }

                var len = arr.length, i = 0, argsLen = args.length, unshift = function (p1, p2) {
                    if (argsLen != args.length) {
                        args.splice(0, 2);
                    }
                    args.unshift(p2);
                    args.unshift(p1);
                    return args;
                };

                if (len === 0) {
                    return;
                } else if (len < 8) {
                    for (; i < len; i += 1) {
                        if (fn.apply(context || window, unshift(arr[i], i)) === true) {
                            break;
                        }
                    }
                } else {

                    var iterations = Math.floor(len / 8), startAt = len % 8;
                    if (startAt != 0) {
                        iterations += 1;
                    }

                    do {
                        switch (startAt) {
                            case 0: if (fn.apply(context || window, unshift(arr[i], i)) === true) return; i += 1;
                            case 7: if (fn.apply(context || window, unshift(arr[i], i)) === true) return; i += 1;
                            case 6: if (fn.apply(context || window, unshift(arr[i], i)) === true) return; i += 1;
                            case 5: if (fn.apply(context || window, unshift(arr[i], i)) === true) return; i += 1;
                            case 4: if (fn.apply(context || window, unshift(arr[i], i)) === true) return; i += 1;
                            case 3: if (fn.apply(context || window, unshift(arr[i], i)) === true) return; i += 1;
                            case 2: if (fn.apply(context || window, unshift(arr[i], i)) === true) return; i += 1;
                            case 1: if (fn.apply(context || window, unshift(arr[i], i)) === true) return; i += 1;
                        }
                        startAt = 0;
                    } while (--iterations > 0)

                    iterations = null;
                    startAt = null;

                }

                unshift = null;
                len = null;
                i = null;

            },
            escapeRe: function (s) {
                return s.replace(_escapeRegex, "\\$1");
            },
            urlAppend: function (url, s) {
                if (!$.isEmpty(s, false)) {
                    return url + (url.indexOf('?') === -1 ? '?' : '&') + s;
                }
                return url;
            },
            urlReplace: function (url, s) {

                if (!$.isEmpty(s, false)) {

                    if (url.indexOf('?') == -1 || s.indexOf('=') == -1) {
                        url = $.urlAppend(url, s);
                    }

                    if (s.indexOf('&') != -1) {

                        var plist = s.split('&');
                        for (var i = 0, len = plist.length; i < len; i++) {
                            url = $.urlReplace(url, plist[i]);
                        }

                    } else {

                        var arr = s.split('=');
                        if (url.indexOf('?' + arr[0]) == -1 && url.indexOf('&' + arr[0]) == -1) {
                            url = $.urlAppend(url, s);
                        } else {
                            url = url.replace(arr[0] + '=' + $.urlParam(arr[0], url), s);
                        }
                    }

                }

                return url;

            },
            urlParam: function (key, s) {

                if (!$.isEmpty(key, false)) {

                    s = $.isEmpty(s, false) ? window.location.search : s;

                    var r = new RegExp('(?:\\?|&)+' + key + '=([^&]+)(?:&|$)+', 'gi');
                    return r.test(s.replace(/&amp;/g, '&')) ? RegExp.$1 : '';

                }

            },
            urlEncode: function (o, pre) {

                var empty, buf = [], e = encodeURIComponent;
                $.iterate(o, function (key, item) {

                    empty = $.isEmpty(item);

                    ext_each(empty ? key : item, function (val) {
                        buf.push('&', e(key), '=', (!$.isEmpty(val) && (val != key || !empty)) ? ($.isDate(val) ? $.urlEncode(val).replace(/"/g, '') : e(val)) : '');
                    });

                });

                if (!pre) {
                    buf.shift();
                    pre = '';
                }

                var re = pre + buf.join('');

                //clear
                empty = null;
                buf = null;
                e = null;

                return re;

            },
            urlDecode: function (string, overwrite) {

                if ($.isEmpty(string, false)) {
                    return {};
                }

                if (string.indexOf('?') != -1) {
                    string = string.split('?')[1];
                }
                if (string.indexOf('#') != -1) {
                    string = string.split('#')[0];
                }

                var obj = {}, pairs = string.split('&'), d = decodeURIComponent, name, value;
                for (var i = 0, len = pairs.length, pair; i < len; i++) {
                    pair = pairs[i].split('=');
                    name = d(pair[0]);
                    value = d(pair[1]);
                    obj[name] = overwrite || !obj[name] ? value : [].concat(obj[name]).concat(value);
                }

                return obj;

            },
            notLocalUrl: (function () {

                var fn = function (s) {
                    $(s).each(function () {

                        try {
                            if (this.tagName && this.tagName.toLowerCase() === 'a' && this.href && this.href.indexOf('javascript:') == -1)
                                if (this.href.indexOf(location.host) == -1)  //非本域链接就在新窗口中打开，以免外部网页破坏本站结构
                                    this.target = '_blank';
                        } catch (error) {
                            //非正常URL，出错后就不让客户点击
                        }

                    });
                };

                return function (selector) {
                    setTimeout(function () {
                        if (selector == undefined) {
                            fn('a');
                        }
                        if ($.isArray(selector)) {
                            this.foreach_array(fn, selector);
                        } else {
                            fn(selector);
                        }
                    }, 300);
                };

            })(),
            formSerialize: (function () {

                var en = function (o, ft) {
                    if ($.isEmpty(ft, false)) { ft = 'o'; }
                    return ft === 'o' ? o : $.urlEncode(o);
                }

                return function (formname, ft, map, excludes) {

                    if ($.isEmpty(formname)) { return re({}); }

                    var result = {}, mapIsEmpty = $.isEmpty(map), excludesIsEmpty = $.isEmpty(excludes);
                    $.foreach_array(function (item, index, inputel, modelname) {

                        if (!excludesIsEmpty && !$.isEmpty(excludes[item.name])) {//可以排除某些不需要序列化的字段
                            return false; //continue
                        }

                        if (!mapIsEmpty && !$.isEmpty(map[item.name])) {//优先使用map中配置的映射
                            result[map[item.name]] = item.value;
                        } else {
                            inputel = $('#' + item.name.replace('$', '_'));
                            if (inputel.length > 0) {//使用在input标签上声明的modelname
                                modelname = inputel.attr('modelname');
                                if (!$.isEmpty(modelname, false)) {
                                    result[modelname] = item.value;
                                    return false; //continue
                                }
                            }
                            if (!$.isEmpty(result[item.name])) {
                                result[item.name] = result[item.name] + ',' + item.value;
                            } else
                                result[item.name] = item.value;

                        }

                    }, ((typeof formname === 'string') ? $('#' + formname) : $(formname)).serializeArray());

                    var re = en(result, ft)

                    //clear
                    mapIsEmpty = null;
                    excludesIsEmpty = null;
                    excludes = null;
                    formname = null;
                    map = null;
                    ft = null;

                    return re;

                }


            })(),
            finallyStyle: function (elem, attr) {
                if (elem.style[attr]) {
                    return elem.style[attr];
                } else if (elem.currentstyle) {
                    return elem.currentstyle[attr];
                } else if (document.defaultview && document.defaultview.getcomputedstyle) {
                    return document.defaultview.getcomputedstyle(elem, null).getpropertyvalue(attr.replace(/([a-z])/g, '-$1').tolowercase());
                } else {
                    return null;
                }
            },
            getHead: (function () {
                var head;
                return function () {
                    if (head == undefined) {
                        head = document.getElementsByTagName("head")[0];
                    }
                    return head;
                };
            })(),
            getBody: function () {
                return document.body || document.documentElement;
            },
            setWndResizeHandler: function (doResize, params, scope) {

                if (!$.isEmpty(params)) {
                    if (!$.isArray(params)) {
                        params = [params];
                    }
                } else {
                    params = [];
                }

                if (top.location.href == location.href && typeof (window.orientation) != 'undefined') {//智能移动设备
                    $(window).bind('orientationchange', function () {
                        if ($.os.isAndroid) {
                            timer = setTimeout(function () { doResize.apply(scope || window, params); }, 500);
                        } else {
                            doResize.apply(scope || window, params);
                        }

                    });

                } else {//pc
                    if ($.browser.ff || $.browser.safari || $.browser.opera) {
                        $(window).resize(function () {
                            doResize.apply(scope || window, params);
                        });
                    } else {

                        var timer;
                        $(window).resize(function () {

                            if (timer !== undefined) {
                                clearTimeout(timer);
                            }

                            timer = setTimeout(function () { doResize.apply(scope || window, params); }, 100);

                        });
                    }
                }
            },
            JSON: (function () {//JSON对象处理

                var 
                    useHasOwn = !!{}.hasOwnProperty,
                    pad = function (n) { return n < 10 ? '0' + n : n; },
                    doEncode = function (o) {
                        if ($.isEmpty(o)) {
                            return 'null';
                        } else if ($.isArray(o)) {
                            return encodeArray(o);
                        } else if ($.isDate(o)) {
                            return '"' + $.dt.format(o, $.dt.sortableDateTime) + '"';
                        } else if ($.isString(o)) {
                            return encodeString(o);
                        } else if (typeof o === 'number') {//don't use isNumber here, since finite checks happen inside isNumber
                            return isFinite(o) ? o + '' : 'null';
                        } else if ($.isBoolean(o)) {
                            return o.toString();
                        } else {
                            var a = ['{'], b, i, v;
                            for (i in o) {
                                if (!o.getElementsByTagName) {// don't encode DOM objects 

                                    if (!useHasOwn || Object.prototype.hasOwnProperty.call(o, i)) {
                                        v = o[i];
                                        switch (typeof v) {
                                            case 'undefined':
                                            case 'function':
                                            case 'unknown':
                                                break;
                                            default:
                                                if (b) {
                                                    a.push(',');
                                                }
                                                a.push(doEncode(i), ':', v === null ? 'null' : doEncode(v));
                                                b = true;
                                        }
                                    }
                                }
                            }
                            a.push('}');
                            return a.join('');
                        }
                    }, m = {
                        "\b": '\\b',
                        "\t": '\\t',
                        "\n": '\\n',
                        "\f": '\\f',
                        "\r": '\\r',
                        '"': '\\"',
                        "\\": '\\\\'
                    },
                    encodeString = function (s) {
                        if (/["\\\x00-\x1f]/.test(s)) {
                            return '"' + s.replace(/([\x00-\x1f\\"])/g, function (a, b) {
                                var c = m[b];
                                if (c) {
                                    return c;
                                }
                                c = b.charCodeAt();
                                return '\\u00' + Math.floor(c / 16).toString(16) + (c % 16).toString(16);
                            }) + '"';
                        }
                        return '"' + s + '"';
                    },
                    encodeArray = function (o) {
                        var a = ['['], b, i, l = o.length, v;
                        for (i = 0; i < l; i++) {
                            v = o[i];
                            switch (typeof v) {
                                case 'undefined':
                                case 'function':
                                case 'unknown':
                                    break;
                                default:
                                    if (b) {
                                        a.push(',');
                                    }
                                    a.push(v === null ? 'null' : $.JSON.encode(v));
                                    b = true;
                            }
                        }
                        a.push(']');
                        return a.join('');
                    };

                return {
                    encode: function (o) {

                        //if (typeof JSON !== 'undefined' && typeof JSON.stringify !== 'undefined') {
                        //    return JSON.stringify(o);
                        //}
                        return doEncode(o);

                    },
                    decodeDate: function (s) {
                        return _decodeDateRegex.test(s) || /^(\d{2,4})\/(\d{1,2})\/(\d{1,2})(?:\s+(\d{1,2}):(\d{1,2}):(\d{1,2}))?/gi.test(s)
                            ? new Date(
                                RegExp.$1, //年
                                parseInt(RegExp.$2, 10) - 1, //月
                                RegExp.$3, //日
                                (typeof RegExp.$4 === 'undefined' || RegExp.$4 === '' ? 0 : RegExp.$4), //时
                                (typeof RegExp.$5 === 'undefined' || RegExp.$5 === '' ? 0 : RegExp.$5), //分
                                (typeof RegExp.$6 === 'undefined' || RegExp.$6 === '' ? 0 : RegExp.$6), //秒
                                (typeof RegExp.$7 === 'undefined' || RegExp.$7 === '' ? 0 : RegExp.$7)//毫秒
                            )
                            : undefined;
                    },
                    decodeDate2: function (s) {
                        if (/(Date)/gi.test(s))
                            return eval('new ' + s.replace(/\//g, '').replace('+0800', ''));
                        else {

                            return $.JSON.decodeDate(s)
                        }

                    },
                    decode: function (s) {
                        return $.parseJSON(s);
                    }
                };

            })(),
            os: {//平台类型检查
                isWindows: checkua(/windows|win32/i),
                isLinux: checkua('linux'),
                isAir: checkua('adobeair'),
                isMac: checkua(/macintosh|mac os x/i),
                isIPad: checkua('ipad'),
                isIPhone: checkua('iphone'),
                isWinPhone: checkua('windows phone'),
                isAndroid: checkua('android'),
                isMobile: function () {
                    return $.os.isIPad || $.os.isIPhone || $.os.isAndroid || $.os.isWinPhone;
                }
            },
            dt: (function () {

                var _shortDate = 'yyyy-MM-dd';
                var _longDate = 'yyyy-MM-dd HH:mm:ss';
                var _sortableDateTime = 'yyyy-MM-ddTHH:mm:ss';
                var pad = function (n) { return n < 10 ? '0' + n : n; };

                var dayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
                var dayNames_CN = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
                var dayNames_CN_short = ['日', '一', '二', '三', '四', '五', '六'];
                var monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                var monthNames_CN = ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'];
                var monthNames_CN_short = ['一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '十二'];
                var monthNumbers = { Jan: 0, Feb: 1, Mar: 2, Apr: 3, May: 4, Jun: 5, Jul: 6, Aug: 7, Sep: 8, Oct: 9, Nov: 10, Dec: 11 };

                var f = function (w, r, max, offset) {
                    if (!$.isNumber(w) || (w < 0 && w > max) || $.isEmpty(r)) {
                        return undefined;
                    }
                    return r[w - offset];
                }
                var setd = function (d, fs, interval) {
                    var dd = new Date();
                    switch (fs) {
                        case 'y': d.setYear(d.getFullYear() + interval); break;
                        case 'M': d.setMonth(d.getMonth() + interval); break;
                        case 'd': d.setDate(d.getDate() + interval); break;
                        case 'm': d.setMinutes(d.getMinutes() + interval); break;
                        case 's': d.setSeconds(d.getSeconds() + interval); break;
                        case 'h':
                        case 'H':
                            d.setHours(d.getHours() + interval); break;
                    }
                    return d;
                }

                return {
                    shortDate: _shortDate,
                    longDateTime: _longDate,
                    sortableDateTime: _sortableDateTime,

                    format: function (d, fs) {//y-年,M-月,d-日,H-时（24小时制）,h-时（12小时制）,m-分,s-秒
                        if (!d) {
                            return undefined;
                        }
                        if ($.isEmpty(fs, false)) {
                            fs = _longDate;
                        }

                        var pro = Date.prototype;

                        var y = pro.getFullYear.call(d) + '';
                        if (isNaN(y)) y = 0;

                        if (fs.indexOf('yyyy') != -1) fs = fs.replace('yyyy', y);
                        else if (fs.indexOf('yy') != -1) fs = fs.replace('yy', y.substr(2));
                        else if (fs.indexOf('y') != -1) fs = fs.replace('y', y);

                        var m = pro.getMonth.call(d);
                        if (isNaN(m)) m = 0;
                        m += 1;
                        if (fs.indexOf('MM') != -1) fs = fs.replace('MM', pad(m));
                        else if (fs.indexOf('M') != -1) fs = fs.replace('M', m);

                        var D = pro.getDate.call(d);
                        if (isNaN(D)) D = 0;
                        if (fs.indexOf('dd') != -1) fs = fs.replace('dd', pad(D));
                        else if (fs.indexOf('d') != -1) fs = fs.replace('d', D);

                        var H = pro.getHours.call(d);
                        if (isNaN(H)) H = 0;
                        if (fs.indexOf('HH') != -1) fs = fs.replace('HH', pad(H));
                        else if (fs.indexOf('H') != -1) fs = fs.replace('H', H);
                        else if (fs.indexOf('hh') != -1) fs = fs.replace('hh', pad(H > 12 ? H - 12 : H));
                        else if (fs.indexOf('h') != -1) fs = fs.replace('h', H > 12 ? H - 12 : H);

                        var min = pro.getMinutes.call(d);
                        if (isNaN(min)) min = 0;
                        if (fs.indexOf('mm') != -1) fs = fs.replace('mm', pad(min));
                        else if (fs.indexOf('m') != -1) fs = fs.replace('m', min);

                        var s = pro.getSeconds.call(d);
                        if (isNaN(s)) s = 0;
                        if (fs.indexOf('ss') != -1) fs = fs.replace('ss', pad(s));
                        else if (fs.indexOf('s') != -1) fs = fs.replace('s', s);

                        return fs;

                    },
                    formatToYdlDate: function (d) {

                        if (typeof d == 'string') {
                            d = $.dt.convert(d);
                        }

                        var now = new Date();
                        var year = d.getYear();
                        var month = d.getMonth();
                        var day = d.getDate();
                        var hour = d.getHours();
                        var minute = d.getMinutes();
                        var second = d.getSeconds();
                        var sd = (hour === 0 && minute === 0 && second === 0);

                        if (now.getYear() == year) {

                            if (now.getMonth() == month && now.getDate() == day) {//今天

                                return sd
                                    ? '今日'
                                    : $.dt.format(d, '今日 HH:mm');

                            } else if (now.getMonth() == month) {//本月

                                var dd = now.getDate() - day;

                                if (sd) {

                                    if (dd == 1)
                                        return "昨日";
                                    else if (dd == 2)
                                        return "前日";
                                    else
                                        return $.dt.format(d, 'MM-dd');

                                } else {
                                    if (dd == 1)
                                        return $.dt.format(d, '昨日 HH:mm');
                                    else if (dd == 2)
                                        return $.dt.format(d, '前日 HH:mm');
                                    else
                                        return $.dt.format(d, 'MM-dd HH:mm');
                                }


                            } else {

                                return sd
                                    ? $.dt.format(d, 'MM-dd')
                                    : $.dt.format(d, 'MM-dd HH:mm');

                            }

                        } else {

                            return sd
                                ? $.dt.format(d, 'yyyy-MM-dd')
                                : $.dt.format(d, 'yyyy-MM-dd HH:mm');

                        }

                    },
                    getWeekName: function (w) { return f(w, dayNames, 6, 0); },
                    getWeekCnName: function (w) { return f(w, dayNames_CN, 6, 0); },
                    getWeekCnShortName: function (w) { return f(w, dayNames_CN_short, 6, 0); },
                    getMonthName: function (m) { return f(m, monthNames, 12, 1); },
                    getMonthCnName: function (m) { return f(m, monthNames_CN, 12, 1); },
                    getMonthCnShortName: function (m) { return f(m, monthNames_CN_short, 12, 1); },
                    getMonthNumber: function (m) { return monthNumbers[m]; },
                    add: function (d, fs, interval) {
                        if ($.isEmpty(d)) {
                            return undefined;
                        }
                        if ($.isEmpty(fs, false)) {
                            fs = 'y';
                        }
                        if ($.isEmpty(interval) || !$.isNumber(interval)) {
                            interval = 0
                        }

                        return setd(d, fs, interval);
                    },
                    subtract: function (d, fs, interval) {
                        if ($.isEmpty(d)) {
                            return undefined;
                        }
                        if ($.isEmpty(fs, false)) {
                            fs = 'y';
                        }
                        if ($.isEmpty(interval) || !$.isNumber(interval)) {
                            interval = 0
                        }
                        if (interval > 0) {
                            interval = -interval;
                        }

                        return setd(d, fs, interval);
                    },
                    isLeapYear: function (d) {
                        var year = d.getFullYear();
                        return !!((year & 3) == 0 && (year % 100 || (year % 400 == 0 && year)));
                    },
                    clone: function (d) {
                        return new Date(d.getTime());
                    },
                    convert: function (str/*yyyy-MM-dd HH:mm*/) {

                        if ($.isEmpty(str, false)) {
                            return new Date();
                        }
                        arr = str.split(' ');

                        var a = arr[0].split('-');
                        var b = [];
                        if ($.isEmpty(arr[1], false)) {
                            b = [0, 0];
                        } else {
                            b = arr[1].split(':');
                        }
                        return new Date(
                            parseInt(a[0], 10),
                            parseInt(a[1], 10) - 1,
                            parseInt(a[2], 10),
                            $.isEmpty(b[0], false) ? 0 : parseInt(b[0], 10),
                            $.isEmpty(b[1], false) ? 0 : parseInt(b[1], 10),
                            0,
                            0
                        );

                    }
                };

            })(),
            cookies: (function () {

                var _o = function () {

                    this.get = function (key) {

                        var cookie = document.cookie;
                        var cookieArray = cookie.split(';');
                        for (var i = 0, len = cookieArray.length, val = ''; i < len; i++) {
                            if (cookieArray[i].trim().substr(0, key.length) === key) {
                                val = cookieArray[i].trim().substr(key.length + 1);
                                break;
                            }
                        }
                        return unescape(val);
                    };

                    this.getChild = function (key, childKey) {

                        var child = this.get(key);
                        var childs = child.split('&');

                        for (var i = 0, len = childs.length, val = ''; i < len; i++) {
                            if (childs[i].trim().substr(0, childKey.length) == childKey) {
                                val = childs[i].trim().substr(childKey.length + 1);
                                break;
                            }
                        }
                        return val;
                    };
                    this.set = function (key, value, expires, domain, path) {

                        var cookie = "";

                        if (key !== undefined && value !== undefined) {

                            cookie += key + "=" + escape(value) + ";";

                            if (expires !== undefined)
                                cookie += "expires=" + expires.toGMTString() + ";";
                            if (domain !== undefined)
                                cookie += "domain=" + domain + ";";
                            if (path !== undefined)
                                cookie += "path=" + path + ";";

                        }

                        if (!$.isEmpty(cookie, false)) {
                            document.cookie = cookie;
                        }

                    };
                    this.remove = function (key) {
                        var date = new Date();
                        date.setFullYear(date.getFullYear() - 1);
                        var cookie = " " + key + "=;expires=" + date.toGMTString() + ";"
                        document.cookie = cookie;
                    }
                }

                var _ins;

                return function () {
                    if (_ins === undefined) {
                        _ins = new _o();
                    }
                    return _ins;
                } ();

            })()

        };

    })());

    //浏览器特性检查
    $.browser = $.browser || {};
    $.extend($.browser, (function () {
        //tridentIE渲染引擎//
        var isIE = checkua('ie') || checkua('trident'), docMode = document.documentMode;
        var isIE7 = isIE && (checkua(/msie 7/i) || docMode == 7);
        var isIE8 = isIE && (checkua(/msie 8/i) || docMode == 8);
        var isIE9 = isIE && (checkua(/msie 9/i) || docMode == 9);
        var isIE10 = isIE && (checkua(/msie 10/i) || docMode == 10);
        var isIE11 = isIE && (checkua(/rv:11.0/i) || docMode == 11);
        var isIE6 = isIE && !isIE7 && !isIE8 && !isIE9 && !isIE10 && !isIE11;

        var isWebKit = checkua(/webkit/i);
        var isChrome = isWebKit && checkua('chrome');
        var isSafari = !isChrome && checkua('safari');
        var isGecko = !isWebKit && checkua('gecko');
        var chromev = function () { return (isChrome && /Chrome\/(\d+)./i.test(ua)) ? RegExp.$1 : 0; }
        var operaV = function () { return (checkua('opera') && /Version\/(\d+)./i.test(ua)) ? RegExp.$1 : 0; }
        var ffV = function () { return (checkua('mozilla') && /Firefox\/(\d+)./i.test(ua)) ? RegExp.$1 : 0; }

        // remove css image flicker    
        if (isIE6) {
            try { document.execCommand('BackgroundImageCache', false, true); } catch (e) { }
        }

        return {

            docMode: docMode,
            webkit: isWebKit,

            chrome: isChrome,
            chromeVersion: chromev(),

            opera: checkua('opera'),
            operaVersion: operaV(),

            ff: checkua('mozilla'),
            ffVersion: ffV(),

            safari: isSafari,
            safari2: isSafari && checkua(/applewebkit\/4/i),
            safari3: isSafari && checkua(/version\/3/i),
            safari4: isSafari && checkua(/version\/4/i),
            safari5: isSafari && checkua(/version\/5/i),

            ie: isIE,
            ie6: isIE6,
            ie7: isIE7,
            ie8: isIE8,
            ie9: isIE9,
            ie10: isIE10,
            ie11: isIE11,
            ieVersion: docMode,

            gecko: isGecko,
            gecko2: isGecko && checkua(/rv:1\.8/i),
            gecko3: isGecko && checkua(/rv:1\.9/i),

            secure: window.location.protocol.indexOf('https') !== -1

        };

    })());

    //数据类型验证
    $.extend($, (function () {

        var toString = Object.prototype.toString;
        var valueOf = Object.prototype.valueOf;

        return {
            isEmpty: function (v, allowBlank) { return v === null || v === undefined || ($.isArray(v) && !v.length) || (!allowBlank ? v === '' : false); },
            isArray: function (v) { return toString.apply(v) === '[object Array]'; },
            isDate: function (v) { return toString.apply(v) === '[object Date]'; },
            isObject: function (v) { return !!v && toString.call(v) === '[object Object]'; },
            isPrimitive: function (v) { return $.isString(v) || $.isNumber(v) || $.isBoolean(v); }, //是否是基础数据类型
            isFunction: function (v) { return toString.apply(v) === '[object Function]'; },
            isNumber: function (v) { return typeof v === 'number' && isFinite(v); },
            isString: function (v) { return typeof v === 'string'; },
            isBoolean: function (v) { return typeof v === 'boolean'; },
            isElement: function (v) { return v ? !!v.tagName : false; },
            isDefined: function (v) { return typeof v !== 'undefined'; },
            isHTMLOptionElement: function (v) {

                return toString.call(v) === '[object HTMLOptionElement]'

            },
            isIterable: function (v) {
                if ($.isArray(v) || v.callee) {
                    return true;
                }
                if (/NodeList|HTMLCollection/.test(toString.call(v))) {
                    return true;
                }
                return ((typeof v.nextNode !== 'undefined' || v.item) && $.isNumber(v.length));
            }
        };

    })());

    //扩展Array对象
    $.extend(Array.prototype, {
        indexOf: typeof Array.prototype.indexOf !== 'undefined' ? Array.prototype.indexOf : function (o, startIndex) {

            if ($.isEmpty(o)) {
                return -1;
            }
            if (!$.isNumber(startIndex)) {
                startIndex = 0;
            }
            for (var len = this.length, itm; startIndex < len; startIndex++) {
                itm = this[startIndex];
                if (itm === o) {
                    return startIndex;
                }
            }

            return -1;

        },
        remove: typeof Array.prototype.remove !== 'undefined' ? Array.prototype.remove : function (o) {
            for (var i = 0, len = this.length; i < len; i++) {
                if (this[i] === o) {
                    return this.splice(i, 1);
                }
            }
        },
        clone: typeof Array.prototype.clone !== 'undefined' ? Array.prototype.clone : function () {
            var a = [];
            Array.prototype.push.apply(a, this);
            return a;
        }
    });

    //扩展字符串对象    
    $.extend(String, (function () {

        var 
        _escape = /('|\\|")/g,
        _r1 = /<script[^>.]*>[sS]*?<\/script>/gim,
        _r2 = /<style[^>.]*>[sS]*?<\/style>/gim,
        _r3 = /<(.| )+?>/gim;


        return {
            escape: typeof String.escape !== 'undefined' ? String.escape : function (s) {

                if ($.isEmpty(s, false)) {
                    return s;
                }
                return s.replace(_escape, '\\$1');

            },
            format: typeof String.format !== 'undefined' ? String.format : function () {
                var len = arguments.length;

                if (len <= 0) {
                    return '';
                }
                if (len == 1) {
                    return arguments[0];
                }

                var s = arguments[0];
                if ($.isEmpty(s, false)) {
                    return s;
                }

                for (var i = 1; i < len; i++) {
                    s = s.replace(new RegExp('\\{' + (i - 1) + '\\}', 'g'), arguments[i]);
                }

                return s;

            },
            htmlEncode: function (s) {
                return (s + '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\"/g, '&quot;');
            },
            htmlDecode: function (s) {
                return (s + '').replace(/&amp;/g, '&').replace(/&quot;/g, '\"').replace(/&lt;/g, '<').replace(/&gt;/g, '>');
            },
            clearHtml: function (html) {
                if ($.isEmpty(html) || !$.isString(html)) return html;
                return html.replace(_r1, '').replace(_r2, '').replace(_r3, '').replace(/&nbsp;/gi, '');
            },
            hasHtmlTag: function (html) {
                return /<\/?[^>]+>/gi.test(html);
            },
            textAreaEncode: function (s) {
                if (s)
                    return (s + '').replace(/ /gi, '&nbsp;').replace(/\n/gi, '<br/>');
                else
                    return s;
            },
            textAreaDecode: function (s) {
                if (s)
                    return (s + '').replace(/\&nbsp;/gi, ' ').replace(/<br\/?>/gi, '\n');
                else
                    return s;
            },
            replaceEnter: function (s) {
                if (s)
                    return (s + '').replace(/\r\n/gi, '<br/>').replace(/\r/gi, '<br/>').replace(/\n/gi, '<br/>');
                else
                    return s;
            },
            buffer: function (s) {
                var _buf = [];
                if (s !== undefined) {
                    _buf.push(s);
                }

                this.append = function () {
                    if (arguments.length > 1) {
                        Array.prototype.push.apply(_buf, arguments);
                    } else if (arguments.length == 1) {
                        if ($.isArray(arguments[0])) {
                            Array.prototype.push.apply(_buf, arguments[0]);
                        } else {
                            _buf.push(arguments[0]);
                        }
                    }
                }
                this.appendLine = function () {
                    this.append.apply(this, arguments);
                    _buf.push('\n');
                }
                this.appendFormat = function () {

                    if (arguments.length == 0) {
                        return;
                    }
                    if (arguments.length == 1) {
                        _buf.push(arguments[0]);
                        return;
                    }

                    _buf.push(String.format.apply(String, arguments));

                }
                this.clear = function () {
                    _buf.length = 0;
                }
                this.toString = this.valueOf = function () {
                    return _buf.join('');
                }
            },
            ToCnNum: function (dValue, maxDec) {
                // 验证输入金额数值或数值字符串：
                dValue = dValue.toString().replace(/,/g, "").replace(/^0+/, "");      // 金额数值转字符、移除逗号、移除前导零
                if (dValue == "" || isNaN(dValue)) { return "零"; }

                var minus = "";                             // 负数的符号“-”的大写：“负”字。可自定义字符，如“（负）”。
                var CN_SYMBOL = "";                         // 币种名称（如“人民币”，默认空）
                if (dValue.length > 1) {
                    if (dValue.indexOf('-') == 0) { dValue = dValue.replace("-", ""); minus = "负"; }   // 处理负数符号“-”
                    if (dValue.indexOf('+') == 0) { dValue = dValue.replace("+", ""); }                 // 处理前导正数符号“+”（无实际意义）
                }

                // 变量定义：
                var vInt = ""; var vDec = "";               // 字符串：金额的整数部分、小数部分
                var resAIW;                                 // 字符串：要输出的结果
                var parts;                                  // 数组（整数部分.小数部分），length=1时则仅为整数。
                var digits, radices, bigRadices, decimals; // 数组：数字（0~9——零~玖）；基（十进制记数系统中每个数字位的基是10——拾,佰,仟）；大基（万,亿,兆,京,垓,杼,穰,沟,涧,正）；辅币 （元以下，角/分/厘/毫/丝）。
                var zeroCount;                              // 零计数
                var i, p, d;                                // 循环因子；前一位数字；当前位数字。
                var quotient, modulus;                      // 整数部分计算用：商数、模数。
                // 金额数值转换为字符，分割整数部分和小数部分：整数、小数分开来搞（小数部分有可能四舍五入后对整数部分有进位）。
                var NoneDecLen = (typeof (maxDec) == "undefined" || maxDec == null || Number(maxDec) < 0 || Number(maxDec) > 5);     // 是否未指定有效小数位（true/false）
                parts = dValue.split('.');                      // 数组赋值：（整数部分.小数部分），Array的length=1则仅为整数。
                if (parts.length > 1) {
                    vInt = parts[0]; vDec = parts[1];           // 变量赋值：金额的整数部分、小数部分

                    if (NoneDecLen) { maxDec = vDec.length > 5 ? 5 : vDec.length; }                                  // 未指定有效小数位参数值时，自动取实际小数位长但不超5。
                    var rDec = Number("0." + vDec);
                    rDec *= Math.pow(10, maxDec); rDec = Math.round(Math.abs(rDec)); rDec /= Math.pow(10, maxDec); // 小数四舍五入
                    var aIntDec = rDec.toString().split('.');
                    if (Number(aIntDec[0]) == 1) { vInt = (Number(vInt) + 1).toString(); }                           // 小数部分四舍五入后有可能向整数部分的个位进位（值1）
                    if (aIntDec.length > 1) { vDec = aIntDec[1]; } else { vDec = ""; }
                }
                else { vInt = dValue; vDec = ""; if (NoneDecLen) { maxDec = 0; } }
                if (vInt.length > 44) { return "错误：数值太大了！整数位长【" + vInt.length.toString() + "】超过了上限——44位/千正/10^43（注：1正=1万涧=1亿亿亿亿亿，10^40）！"; }

                // 准备各字符数组 Prepare the characters corresponding to the digits:
                digits = new Array("零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖");         // 零~玖
                radices = new Array("", "拾", "佰", "仟");                                              // 拾,佰,仟
                bigRadices = new Array("", "万", "亿", "兆", "京", "垓", "杼", "穰", "沟", "涧", "正"); // 万,亿,兆,京,垓,杼,穰,沟,涧,正
                decimals = new Array("角", "分", "厘", "毫", "丝");                                     // 角/分/厘/毫/丝

                resAIW = ""; // 开始处理

                // 处理整数部分（如果有）
                if (Number(vInt) > 0) {
                    zeroCount = 0;
                    for (i = 0; i < vInt.length; i++) {
                        p = vInt.length - i - 1; d = vInt.substr(i, 1); quotient = p / 4; modulus = p % 4;
                        if (d == "0") { zeroCount++; }
                        else {
                            if (zeroCount > 0) { resAIW += digits[0]; }
                            zeroCount = 0; resAIW += digits[Number(d)] + radices[modulus];
                        }
                        if (modulus == 0 && zeroCount < 4) { resAIW += bigRadices[quotient]; }
                    }
                    resAIW += "元";
                }

                // 处理小数部分（如果有）
                for (i = 0; i < vDec.length; i++) { d = vDec.substr(i, 1); if (d != "0") { resAIW += digits[Number(d)] + decimals[i]; } }

                // 处理结果
                if (resAIW == "") { resAIW = "零元"; }     // 零元
                if (vDec == "") { resAIW += "整"; }             // ...元整
                resAIW = CN_SYMBOL + minus + resAIW;            // 人民币/负......元角分/整
                return resAIW;
            }
        }

    })());
    $.extend(String.prototype, (function () {

        var _padChr = function (len, chr) {
            var tmp = new Array(len);
            if (len > 10) {// Duff's Device
                var iterations = Math.floor(len / 8), startAt = len % 8, i = 0;
                do {
                    switch (startAt) {
                        case 0: tmp[i++] = chr;
                        case 7: tmp[i++] = chr;
                        case 6: tmp[i++] = chr;
                        case 5: tmp[i++] = chr;
                        case 4: tmp[i++] = chr;
                        case 3: tmp[i++] = chr;
                        case 2: tmp[i++] = chr;
                        case 1: tmp[i++] = chr;
                    }
                    startAt = 0;
                } while ((--iterations >= 0))

            } else {
                for (var i = 0; i < len; i++) {
                    tmp[i] = chr;
                }
            }
            return tmp;
        },
        _leftPad = function (s, len, chr) {
            if (chr.length > 1) {
                chr = chr.charAt(0);
            }
            var a = _padChr(len - s.length, chr);
            a.push(s);

            return a.join('');
        },
        _rightPad = function (s, len, chr) {
            if (chr.length > 1) {
                chr = chr.charAt(0);
            }
            var a = [s];
            Array.prototype.push.apply(a, _padChr(len - s.length, chr));

            return a.join('');
        };

        return {
            trim: typeof String.prototype.trim !== 'undefined' ? String.prototype.trim : function () {
                return $.trim(this);
            },
            toggle: typeof String.prototype.toggle !== 'undefined' ? String.prototype.toggle : function (s1, s2) {
                return this == s1 ? s2 : s1;
            },
            leftPad: typeof String.prototype.leftPad !== 'undefined' ? String.prototype.leftPad : function (len, chr) {
                return _leftPad(this, len, chr);
            },
            rightPad: typeof String.prototype.rightPad !== 'undefined' ? String.prototype.rightPad : function (len, chr) {
                return _rightPad(this, len, chr);
            },
            escape: typeof String.prototype.escape !== 'undefined' ? String.prototype.escape : function () {
                return String.escape(this);
            },
            format: typeof String.prototype.format !== 'undefined' ? String.prototype.format : function () {
                var a = [this];
                Array.prototype.push.apply(a, arguments)
                return String.format.apply(String, a);
            },
            //将json时间格式化
            todate: typeof String.prototype.todate !== 'undefined' ? String.prototype.todate : function () {
                var dateMilliseconds;
                if (isNaN(this)) {
                    //使用正则表达式将日期属性中的非数字（\D）删除
                    dateMilliseconds = this.replace(/\D/igm, "");
                } else {
                    dateMilliseconds = this;
                }
                //实例化一个新的日期格式，使用1970 年 1 月 1 日至今的毫秒数为参数
                return new Date(parseInt(dateMilliseconds));
            }
        }

    })());

    //扩展Math对象
    $.extend(Math, {

        formatNumber: function (v, p) {

            if ($.isEmpty(v, false)) {//undefined,null,''
                return 'NaN';
            }
            if (!$.isNumber(v)) {//'123.55'
                v = Number(v);
            }
            if (typeof p != 'number') {
                p = 0;
            }

            if (isNaN(v)) return 'NaN';
            if (p <= 0) return Math.floor(v);

            try {
                return v.toFixed(p);
            } catch (e) {
                return 0;
            }
        }

    });

    //扩展日期对象
    $.extend(Date.prototype, {
        add: function (fs, interval) {
            $.dt.add(this, fs, interval);
        },
        subtract: function (fs, interval) {
            $.dt.subtract(this, fs, interval);
        },
        format: function (fs) {
            return $.dt.format(this, fs);
        },
        formatToYdlDate: function (fs) {
            return $.dt.formatToYdlDate(this);
        },
        isLeapYear: function () {
            return $.dt.isLeapYear(this);
        },
        clone: function () {
            return $.dt.clone(this);
        }
    });

    //扩展函数对象
    $.extend(Function.prototype, (function () {

        return {//这几个函数都是冲Ext中移植过来的，非常有用
            createCallback: function () {
                var fn = this, args = arguments;
                return function () {
                    fn.apply(window, args);
                }
            },
            createDelegate: function (obj, args, appendArgs) {

                var fn = this;

                if (!$.isEmpty(args) && !$.isArray(args)) {
                    args = [args];
                }

                return function () {

                    var callArgs = args || arguments;
                    if (appendArgs === true) {

                        callArgs = Array.prototype.slice.call(arguments, 0);
                        Array.prototype.push.apply(callArgs, args);

                    } else if ($.isNumber(appendArgs)) {

                        callArgs = Array.prototype.slice.call(arguments, 0);

                        var applyArgs = [appendArgs, 0]
                        Array.prototype.push.apply(applyArgs, args);

                        Array.prototype.splice.apply(callArgs, applyArgs);

                    }

                    return fn.apply(obj || window, callArgs);

                };
            },
            createInterceptor: function (fcn, scope) {
                var method = this;
                return !$.isFunction(fcn) ?
                    method : function () {
                        var me = this, args = arguments;
                        fcn.target = me;
                        fcn.method = method;
                        return (fcn.apply(scope || me || window, args) !== false) ? method.apply(me || window, args) : null;
                    };
            },
            createSequence: function (fcn, scope) {
                var method = this;
                return (!$.isFunction(fcn)) ?
                    method : function () {
                        var retval = method.apply(this || window, arguments);
                        fcn.apply(scope || this || window, arguments);
                        return retval;
                    };
            },
            defer: function (millis, obj, args, appendArgs) {
                var fn = this.createDelegate(obj, args, appendArgs);
                if (millis > 0) {
                    return setTimeout(fn, millis);
                }
                fn();
                return 0;
            }
        };

    })())

})(jQuery, window);

//JS版的ResourceRef.Url
var convertUrl = function (url) {

    if ($.isEmpty(url, false)) {
        return '';
    }
    var vp = globalConfig.virtualPath;
    if (vp === '/') {
        return url.replace('~/', '/');
    } else {
        if (vp.substr(vp.length - 1) !== '/') {
            return url.replace('~/', vp + '/');
        } else {
            return url.replace('~/', vp);
        }
    }
}

//JS版的处理图片、视频、Flash等路径
function convertHtmContentMediaUrl(source) {
    if ($.isEmpty(source, false)) return source;

    var reg = new RegExp("src=[\",\']?((\\.\\.)?/)*([^\\\\,/,:,*,\\?,\",\\|,<,>]+/)+[^\\\\,/,:,*,\\?,\",\\|,<,>]+\\.[a-z]{2,4}[\",\']?", 'gi');
    var subreg = new RegExp("((\\.\\.)?/)*([^\\\\,/,:,*,\\?,\",\\|,<,>]+/)+[^\\\\,/,:,*,\\?,\",\\|,<,>]+\\.[a-z]{2,4}", 'gi');

    var machs = source.match(reg);

    if (machs != null) {
        for (var i = 0, len = machs.length, m, sm, sub_machs; i < len; i++) {
            m = machs[i];
            sub_machs = m.match(subreg);

            if (sub_machs.length > 0) {
                sm = sub_machs[0].replace(/(\.\.\/)+/, '').replace('~/', '');
                if (globalConfig.virtualPath != '/')
                    sm = sm.replace(new RegExp('\\/?' + globalConfig.virtualPath.replace(/\//gi, '')), '');
                sm = sm.replace(/^\//, '');

                m = machs[i].replace(sub_machs[0], convertUrl('~/' + sm));
                source = source.replace(new RegExp(machs[i], 'gi'), m);
            }

        } 
    }
    return source;
}

//生成QQ链接
function callQQ(qq) {
    var reg = /^(0|[1-9][0-9]*)/;
    if (reg.test(qq)) {
        window.open("http://wpa.qq.com/msgrd?v=1&uin=" + qq + "&site=任我行 官方&menu=yes");
    }
    else {
        top.crm.widgets.MessageBox.error('不是有效的QQ号', '系统提示')
        return false;
    }
}

var labelColor_Cache = null;
var labelColors = ['black',
                    'navy',
                    'darkblue',
                    'mediumblue',
                    'blue',
                    'darkgreen',
                    'green',
                    'teal',
                    'darkcyan',
                    'deepskyblue',
                    'darkturquoise',
                    'midnightblue',
                    'dodgerblue',
                    'lightseagreen',
                    'forestgreen',
                    'seagreen',
                    'darkslategray',
                    'limegreen',
                    'mediumseagreen',
                    'turquoise',
                    'royalblue',
                    'steelblue',
                    'darkslateblue',
                    'mediumturquoise',
                    'indigo',
                    'darkolivegreen',
                    'cadetblue',
                    'cornflowerblue',
                    'mediumaquamarine',
                    'dimgray',
                    'slateblue',
                    'olivedrab',
                    'slategray',
                    'lightslategray',
                    'mediumslateblue',
                    'maroon',
                    'purple',
                    'olive',
                    'gray',
                    'blueviolet',
                    'darkred',
                    'darkmagenta',
                    'saddlebrown',
                    'darkseagreen',
                    'mediumpurple',
                    'darkviolet',
                    'palegreen',
                    'darkorchid',
                    'yellowgreen',
                    'sienna',
                    'brown',
                    'darkgray',
                    'lightblue',
                    'firebrick',
                    'darkgoldenrod',
                    'mediumorchid',
                    'rosybrown',
                    'darkkhaki',
                    'silver',
                    'mediumvioletred',
                    'indianred',
                    'peru',
                    'chocolate',
                    'orchid',
                    'goldenrod',
                    'palevioletred',
                    'crimson',
                    'red',
                    'fuchsia',
                    'deeppink',
                    'orangered',
                    'tomato',
                    'hotpink'
                    ];


//base64编码解码
var _base64encodechars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
var _base64decodechars = new Array(
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1,
    -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1,
    -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1);


function base64encode(str) {
    var out, i, len;
    var c1, c2, c3;
    len = str.length;
    i = 0;
    out = "";
    while (i < len) {
        c1 = str.charCodeAt(i++) & 0xff;
        if (i == len) {
            out += _base64encodechars.charAt(c1 >> 2);
            out += _base64encodechars.charAt((c1 & 0x3) << 4);
            out += "==";
            break;
        }
        c2 = str.charCodeAt(i++);
        if (i == len) {
            out += _base64encodechars.charAt(c1 >> 2);
            out += _base64encodechars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xf0) >> 4));
            out += _base64encodechars.charAt((c2 & 0xf) << 2);
            out += "=";
            break;
        }
        c3 = str.charCodeAt(i++);
        out += _base64encodechars.charAt(c1 >> 2);
        out += _base64encodechars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xf0) >> 4));
        out += _base64encodechars.charAt(((c2 & 0xf) << 2) | ((c3 & 0xc0) >> 6));
        out += _base64encodechars.charAt(c3 & 0x3f);
    }
    return out;
}
function base64decode(str) {
    var c1, c2, c3, c4;
    var i, len, out;
    len = str.length;
    i = 0;
    out = "";
    while (i < len) {

        do {
            c1 = _base64decodechars[str.charCodeAt(i++) & 0xff];
        } while (i < len && c1 == -1);
        if (c1 == -1)
            break;

        do {
            c2 = _base64decodechars[str.charCodeAt(i++) & 0xff];
        } while (i < len && c2 == -1);
        if (c2 == -1)
            break;
        out += String.fromCharCode((c1 << 2) | ((c2 & 0x30) >> 4));

        do {
            c3 = str.charCodeAt(i++) & 0xff;
            if (c3 == 61)
                return out;
            c3 = _base64decodechars[c3];
        } while (i < len && c3 == -1);
        if (c3 == -1)
            break;
        out += String.fromCharCode(((c2 & 0xf) << 4) | ((c3 & 0x3c) >> 2));

        do {
            c4 = str.charCodeAt(i++) & 0xff;
            if (c4 == 61)
                return out;
            c4 = _base64decodechars[c4];
        } while (i < len && c4 == -1);
        if (c4 == -1)
            break;
        out += String.fromCharCode(((c3 & 0x03) << 6) | c4);
    }
    return out;
}


function openWindow(url, w, h, x, y) {
    if (!$.isNumber(x)) x = 100;
    if (!$.isNumber(y)) y = 100;
    var nw = window.open(url, 'newwindow', 'height=' + ($.isNumber(h) ? h : 600) + ',top='+y+',left='+x+',width=' + ($.isNumber(w) ? w : 900) + ',location=no,scrollbars=yes,menubar=no,resizable=yes,toolbar=no,dependent=yes');
    try {
        nw.focus();
    } catch (e) {
        top.crm.widgets.MessageBox.error('浏览器已阻止弹出窗口，操作无法继续。[<a href="' + convertUrl('~/Htmls/WindowSet_Help.htm') + '" target="_blank">更改设置</a>]', '操作失败');
    }
}



//创建一个可释放列表
var globalLeakManager = (function () {

    var _lst = [];
    var _lst2 = [];
    var _lst3 = [];


    return {
        add: function (s, t) {
            if (t == 'timer')
                _lst2.push(s);
            else if (t == 'interval')
                _lst3.push(s);
            else
                _lst.push(s);
        },
        destroy: function () {

            if (_lst.length > 0) {
                for (var i = 0, len = _lst.length; i < len; i++) {
                    try {
                        delete window[_lst[i]];
                    } catch (e) { }
                }
                _lst.length = 0;
            }
            if (_lst2.length > 0) {
                for (var i = 0, len = _lst2.length; i < len; i++) {
                    try {
                        clearTimeout(_lst2[i]);
                    } catch (e) { }
                }
                _lst2.length = 0;
            }
            if (_lst3.length > 0) {

                for (var i = 0, len = _lst3.length; i < len; i++) {
                    try {
                        clearInterval(_lst3[i]);
                    } catch (e) { }
                }
                _lst3.length = 0;
            }

        }
    }

})(jQuery, window);

$(window).unload(function () {
    globalLeakManager.destroy();
});



function getCursorPosition(boxid) {
    var o = { start: 0, end: 0 };

    textBox = document.getElementById(boxid);

    if (textBox == null || textBox == undefined) return o;

    //如果是Firefox(1.5)的话，方法很简单
    if (typeof (textBox.selectionStart) == "number") {
        o.start = textBox.selectionStart;
        o.end = textBox.selectionEnd;
    }
    //下面是IE(6.0)的方法，麻烦得很，还要计算上'/n'
    else if (document.selection) {
        var range = document.selection.createRange();
        if (range.parentElement().id == textBox.id) {
            // create a selection of the whole textarea
            var range_all = document.body.createTextRange();
            range_all.moveToElementText(textBox);
            //两个range，一个是已经选择的text(range)，一个是整个textarea(range_all)
            //range_all.compareEndPoints()比较两个端点，如果range_all比range更往左(further to the left)，则                
            //返回小于0的值，则range_all往右移一点，直到两个range的start相同。
            // calculate selection start point by moving beginning of range_all to beginning of range
            while (range_all.compareEndPoints("StartToStart", range) < 0) {
                range_all.moveStart('character', 1);
                o.start++;
            }
                         
            // create a selection of the whole textarea
            var range_all = document.body.createTextRange();
            range_all.moveToElementText(textBox);
            // calculate selection end point by moving beginning of range_all to end of range
            while (range_all.compareEndPoints('StartToEnd', range) < 0) {
                range_all.moveStart('character', 1);
                o.end++;
            }
                
          
        }
    }

    return o;
}

function moveCursorPosition(boxid, start, end) {


    oTextarea = document.getElementById(boxid);
    if (oTextarea == null || oTextarea == undefined) return;

    if (typeof (oTextarea.selectionStart) == "number") {
        oTextarea.select();
        oTextarea.selectionStart = start;
        oTextarea.selectionEnd = end;
    }
    else {
        var oTextRange = oTextarea.createTextRange();

        var value = oTextarea.value,
            lv = value.substr(0, start),
            rv = value.substr(start),
            matchs = lv.match(/\n/ig);

        //处理回车
        start += matchs == null ? 0 : matchs.length;
        end = value.substr(start).length;
        matchs = rv.match(/\n/ig);
        end -= matchs == null ? 0 : matchs.length;

        oTextRange.moveStart('character', start);
        oTextRange.moveEnd('character', -end); 

        oTextRange.select();
        oTextarea.focus();


    }
}

//固定指定的侧边
function fixedSide(basetop, wh, scrolltop, side, fixedx) {

    var pos_top = basetop + side.outerHeight();
    if (scrolltop > 0 && pos_top - scrolltop < wh) {
        if (side.css('position') != 'fixed') {
            if (fixedx) {
                side.css('left', side.offset().left + 'px');
            }
            side.css({ 'position': 'fixed', 'top': (pos_top < wh ? basetop : wh - pos_top + basetop) + 'px' });

        }

    } else {
        side.css('position', 'static');
    }
}

