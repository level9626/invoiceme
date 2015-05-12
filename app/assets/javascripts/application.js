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

// wysihtml5 Overall confings
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

// Manky patch JS Number class
Number.prototype.round = function(p) {
    p = p || 10;
    return parseFloat( this.toFixed(p) );
};


// Add form serialization functionality to Jquery
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

//Add "Show/Hide" button for each wysihtml5 text editor. Found it as .wysihtml
//class through form -> parent
$(document).ready(function(){
    $(".wysihtml5-toolbar").each(function () {
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
