var invoiceMe = invoiceMe || {};
invoiceMe.invoice = invoiceMe.invoice || {};

invoiceMe.invoice.showInvoiceForm = function () {
    if ( $('#invoice_company_id').val() && $('#invoice_client_id').val() ) {
        $('#client-company').addClass('hidden');
        $('#invoice').removeClass('hidden');
    }
};

$(document).ready( function() {
    // Invoice Logo, client and company CTRL
    invoiceMe.invoice.showInvoiceForm();
    $('#invoice_company_id, #invoice_client_id').change(function (){

        var changed_id      = $(this).val(),
            relation_name   = $(this).data('relation-name'),
            url             = relation_name+'/'+changed_id+'.json';


        $.get(url, null, function (data) {
            if (relation_name=='companies') {
                var logo = '<img height="50" width="50" src="'+data.logo.logo.url+'">'
                $('#logo').html(logo);
            }

            $('#'+relation_name+'_name').text(data.name);
            $('#'+relation_name+'_address').data("wysihtml5").editor.setValue(data.address);
        }, 'json');

        invoiceMe.invoice.showInvoiceForm();
    });
});