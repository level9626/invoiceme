class InvoiceMailer < ActionMailer::Base

  # TODO: test this
  def mail invoice
    pdf = GetInvoicePdfService.new.call invoice

    attachments['invoice.pdf'] = pdf
    {
        to: 'to',
        from: 'from',
        subject: 'subject',
        cc: 'cc',
        body: 'body'
    }
  end
end
