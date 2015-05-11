//Vars namespace for invoiceMe
var invoiceMe = invoiceMe || {};
invoiceMe.invoice = invoiceMe.invoice || {};

/*
 * Invoice Logo, client and company CTRL
 */
$(document).ready( function() {
    // On Client or company field change, call API to receive address texts
    $('#invoice_company_id, #invoice_client_id').change(function (){

        //Relation name is stored in relation-name data attr
        var changed_id      = $(this).val(),
            relation_name   = $(this).data('relation-name'),
            url             = relation_name+'/'+changed_id+'.json';


        $.get(url, null, function (data) {
            if (relation_name=='companies') {
                var logo = '<img height="50" width="50" src="'+data.logo.logo.url+'">'
                $('#logo').html(logo);
            }

            //Fill the fields
            $('#'+relation_name+'_name').text(data.name);
            $('#'+relation_name+'_address').data("wysihtml5").editor.setValue(data.address);
        }, 'json');
    });

    //Initialize CTRL for edit page
    $('#invoice_company_id, #invoice_client_id').trigger('change');
});


/*
 * Invoice search tags CTRL
 */
$(document).ready( function() {
    // Handler for filter clearing
    $('#tags .btn').click(function (){

        //Relation name is stored in relation-name data attr
        var predicate = $(this).attr('id'),
            filter_field = $('#q_' + predicate);

        //Clear field data
        filter_field.val('');
        //Submit search form
        filter_field.closest('form').submit();
    });
});


/*
 * Sidebar toggle animation
 */

$(document).ready(function($){
    $('.btn-group').on('click', function() {
        $(this).find('.cd-btn').on('click', function(){
            $(this).parentsUntil('tr').next('td').addClass('show').css('background-color','red');

        });
    //});
    //$(elem).on('click', function() {
    //    var id = $(this).parentsUntil('table').closest('tr').css('background-color','red');
    //    //var id = '#'+$(elem).data('cd');
        //$(id).addClass('is-visible');
    });

    ////open the lateral panel
    //$('.cd-btn').on('click', function(event){
    //    event.preventDefault();
    //    var id = '#'+$(this).data('cd');
    //    $(id).addClass('is-visible');
    //    //FIND PARENT
    //    //
    //});
    ////clode the lateral panel
    //$('.cd-panel-close').on('click', function(event){
    //    $('.cd-panel').removeClass('is-visible');
    //    event.preventDefault();
    //    return false
    //});
});