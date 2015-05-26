var invoice_mails = invoice_mails || {};

$(document).ready( function() {
    // Parent form
    invoice_mails.form = $('#new_invoice_mail');

    // Event handler
    invoice_mails.form.find('#invoice_mail_invoice_email_template_id')
        .change(function () {
            invoice_mails.url = '/invoice_email_templates/'+
                                $(this).val()+
                                '.json';

            // Dynamically add texts
            $.get(invoice_mails.url, null, function (data) {
                // Add subject value
                invoice_mails.form.find('#invoice_mail_subject')
                    .val(data.template_subject);

                // Add to and cc value
                invoice_mails.form.find('#invoice_mail_to')
                    .val(data.to);
                invoice_mails.form.find('#invoice_mail_cc')
                    .val(data.cc);

                // Add body content
                invoice_mails.form.find('#invoice_mail_body')
                    .data('wysihtml5')
                    .editor
                    .setValue(data.template_body);
            }, 'json');
    });
});