json.array!(@invoice_mails) do |invoice_mail|
  json.extract! invoice_mail, :id, :invoice_id, :to, :user_id, :subject, :cc, :body, :invoice_email_template_id
  json.url invoice_mail_url(invoice_mail, format: :json)
end
