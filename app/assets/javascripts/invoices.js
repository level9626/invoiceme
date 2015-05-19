//Vars namespace for invoiceMe
var invoiceMe = invoiceMe || {};
invoiceMe.invoice = invoiceMe.invoice || {};

/*
 * Invoice Logo, client and company CTRL
 */
$(document).ready( function() {
    // On Client or company field change, call API to receive address texts
    $('#invoice_company_id, #invoice_client_id').change(function (){

        if ( !$(this).val() )
            return null

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
 * Hide button for statistics filters
 */
$(document).ready( function(){
    var url = window.location.href;
    if (url.indexOf("?") == -1) {
        $('#clear-filter').hide();
    } else { $('#clear-filter').show(); }
});


/*
* Submits froms, and opens a new mailing modal
*/
$(document).ready( function() {

    // Invoice front-end form validations
    $("form.new_invoice, form.edit_invoice").validate({
        debug: true,
        errorElement: "span",
        errorClass: "help-block",
        highlight: function (element, errorClass, validClass) {
            $(element).closest('.form-group').addClass('has-error');
        },
        unhighlight: function (element, errorClass, validClass) {
            $(element).closest('.form-group').removeClass('has-error');
        },
        errorPlacement: function (error, element) {
            if (element.parent('.input-group').length || element.prop('type') === 'checkbox' || element.prop('type') === 'radio') {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
        },
        submitHandler: function(form) {
            if ($(form).valid())
                form.submit();
            return false; // prevent normal form posting
        },
        rules: {
            "invoice[invoice_number]":   { required: true },
            "invoice[invoice_date]":     { required: true },
            "invoice[company_id]":       { required: true },
            "invoice[company_row_text]": { required: true },
            ".hours_or_tasks":           { required: true, number: true},
            ".hours_or_tasks":           { required: true, number: true},
            ".rate":                     { required: true, number: true},
            "invoice[currency]":         { required: true },
            "invoice[comment]":          { required: true }
        }
    });

    // Saves the form and opens new mailing dialog
    $('#save-and-send').click(function(e){
        e.preventDefault();

        var form = $(this).parents('form');

        if ( form.valid() ) {
            $.ajax({
                url:    form.attr('action')+'.json',
                type:   form.attr('method'),
                data:   form.serializeObject()
            })
            .done(function(data) {
                $('#mailingModal'+data.id).modal();
            })
            .fail(function(errors) {
                alert('Cant save invoice doe to errors.');
            });
        }

        return false;
    });
});