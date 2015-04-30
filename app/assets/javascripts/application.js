//
//= require jquery
//= require jquery.turbolinks
//= require cocoon
//= require turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require bootstrap-wysihtml5
//= require raphael
//= require morris
//= require_tree .

$(document).ready(function(){
    // Text editor
    $('.wysihtml5').wysihtml5({
        "lists": false,
        "link":  false,
        "image": false,
        "color": true
    });

    // Date and timepicker
    $('.datepicker').datepicker({
        format: 'dd/mm/yyyy',
        startDate: '+1d',
        autoclose: true
    });
});


Number.prototype.round = function(p) {
    p = p || 10;
    return parseFloat( this.toFixed(p) );
};

jQuery(function ($) {
    $('.panel-heading span.clickable').on("click", function (e) {
        if ($(this).hasClass('panel-collapsed')) {
            // expand the panel
            $(this).parents('.panel').find('.panel-body').slideDown();
            $(this).removeClass('panel-collapsed');
            $(this).find('i').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
        }
        else {
            // collapse the panel
            $(this).parents('.panel').find('.panel-body').slideUp();
            $(this).addClass('panel-collapsed');
            $(this).find('i').removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
        }
    });
});

$('.btn').click(function() {
    $('.modal')
        .prop('class', 'modal fade') // revert to default
        .addClass( $(this).data('direction') );
    $('.modal').modal('show');
});

//Add "Show/Hide" button for each wysihtml5 text editor. Found it as .wysihtml
//class through form -> parent
$(document).ready(function(){
    $("form").find(".wysihtml5-toolbar").each(function () {
       // Init event
      $(this).addClass('hidden');
      $(this).parent()
             .prepend('<button class="wys btn-primary btn-xs">Show Editor</button>');
    });

    // Init event handlers
    $('.wys').on('click', function(){
        var that = $(this).parent().find('.wysihtml5-toolbar');

        if (that.hasClass('hidden')){
            $(this).html("Hide editor");
            that.removeClass('hidden');
        }else{
            $(this).html("Show editor");
            that.addClass('hidden')   ;
        }
        return false;
    });
});
