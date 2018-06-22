/// <reference path="jquery/jquery-1.10.2.min.js" />
/// <reference path="jquery/jquery-crmextend-1.0.js" />


$.fn.inputtip = function (msg, isfocus) {

    return this.each(function (i, o, jo) {
        jo = $(this);

        jo.parent().css('position', 'relative')
                    .append('<div class="input-tip" for="' + this.id + '">' + msg + '</div>');
        jo.focusin(on_inputfocus)
          .focusout(on_inputfocusOut);

        var offset = jo.position(),
                    h = jo.outerHeight();

        $('.input-tip[for="' + this.id + '"]').css({
            'left': (offset.left + 5) + 'px',
            'top': offset.top + 'px',
            'height': h + 'px',
            'line-height': h + 'px'
            //'display': $.isEmpty(jo.val(), false) ? '' : 'none'
        })
        .click(on_tipclick);
        if (isfocus)
            jo.focus();
    });

    function on_tipclick(e) {
        $('#' + $(e.target).attr('for')).focus();
    }
    function on_inputfocus(e) {
        $('.input-tip[for="' + e.target.id + '"]').hide();
    }
    function on_inputfocusOut(e) {

        if ($.isEmpty($(e.target).val(), false)) {
            $('.input-tip[for="' + e.target.id + '"]').show();
        }
    }
}