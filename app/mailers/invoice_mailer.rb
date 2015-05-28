class InvoiceMailer < ActionMailer::Base
  def invoice_mail(invoice_mail)
    if !invoice_mail.attachment === false
      attachments['invoice.pdf'] = GetInvoicePdfService.new
                                   .call invoice_mail.invoice
    end

    mail(
      to: invoice_mail.to,
      from: invoice_mail.user.email,
      subject: invoice_mail.subject,
      cc: invoice_mail.cc
    ) do |format|
      format.html { invoice_mail.body }
    end
  end
end
