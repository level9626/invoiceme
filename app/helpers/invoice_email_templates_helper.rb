module InvoiceEmailTemplatesHelper

  # collection: index, create
  def email_templates_path(*args)
    return invoice_email_templates_path(args) unless _class?(args)
    client_invoice_email_templates_path(args)
  end

  # Member show, update, delete
  def email_template(*args)
    return invoice_email_template_path(args) unless _class?(args)
    client_invoice_email_template_path(args)
  end

  # Additional: edit, new
  def new_email_template_path(*args)
    return new_invoice_email_template_path(args) unless _class?(args)
    new_client_invoice_email_template_path(args)
  end

  def edit_email_template_path(*args)
    return edit_invoice_email_template_path(args) unless _class?(args)
    edit_client_invoice_email_template_path(args)
  end

  private

  def _class? args
    args.select{ |obj| obj.is_a? Class }.empty?
  end
end
