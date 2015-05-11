/*
 * Filters on invoice's index page, hidden by default and actions on view page
 */

$(document).ready(function(){
    $('.dropdown_panel').hide();

    $('.panel-heading span.clickable').click(function (e) {
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
});
