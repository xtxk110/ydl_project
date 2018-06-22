/// <reference path="jquery/jquery-1.10.2.min.js" />
/// <reference path="jquery/jquery-crmextend-1.0.js" />


$.ns('crm.msg');
crm.msg = (function ($, window) {

    var _msg = function init(cfg) {

        $.apply(this, cfg || {}, {
            UserCacheKey: '',
            ReceiveFunc: undefined
        });

        if ($.connection && $.connection.chatHub) {

            $.connection.hub.qs = { "CacheKey": this.UserCacheKey };
            this.chatHub = $.connection.chatHub
            this.chatHub.client.PrivateMessageReceived = $.isFunction(this.ReceiveFunc) ? this.ReceiveFunc : function (msg) { };
        }
    }

    var connectHubServer = function () {
        this.chatHub.server.openIm();
    }

    var _openImWindow = function () {
        if (this.chatHub) {
            $.connection.hub.start().done(connectHubServer.createDelegate(this));
        }
    }
    var _closeImWindow = function () {

        if (this.chatHub) {
            $.connection.hub.stop();
        }
    }

    $.extend(_msg.prototype, {
        OpenImWindow: _openImWindow,
        CloseImWindow: _closeImWindow
    });

    return _msg;

})($, window);


