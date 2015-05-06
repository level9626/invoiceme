/*
 * Filters on invoice's index page, hidden by default and actions on view page
 */
var invoice_panels = invoice_panels || {};

jQuery(function ($) {
    $(document).ready(function(){
        invoice_panels.dropdownpanel = $('#main-content').find('.dropdown_panel');
        //invoice_panels.form.find('.dropdown_panel').css("background-color","red");
        $(invoice_panels.dropdownpanel).hide();

        if (invoice_panels.dropdownpanel.hide()) {
            $('.panel-heading span.clickable').on("click", function (e) {
                if (!($(this).hasClass('panel-collapsed'))) {
                    // expand the panel
                    $(this).parents('.panel').find('.panel-body').slideDown();
                    $(this).addClass('panel-collapsed');
                    $(this).find('i').removeClass('glyphicon-chevron-down')
                                     .addClass('glyphicon-chevron-up');
                }
                else {
                    // collapse the panel
                    $(this).parents('.panel').find('.panel-body').slideUp();
                    $(this).removeClass('panel-collapsed');
                    $(this).find('i').removeClass('glyphicon-chevron-up')
                                     .addClass('glyphicon-chevron-down');
                }
            });
        }
    });
});
