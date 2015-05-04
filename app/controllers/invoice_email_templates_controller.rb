class InvoiceEmailTemplatesController < ApplicationController
  before_action :set_invoice_email_template, \
                only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @invoice_email_templates = current_user.invoice_email_templates
  end

  def show
    respond_with(@invoice_email_template)
  end

  def new
    @invoice_email_template = InvoiceEmailTemplate.new
  end

  def edit
  end

  def create
    @invoice_email_template = current_user.invoice_email_templates
                              .new(invoice_email_template_params)

    if @invoice_email_template.save
      redirect_to @invoice_email_template, \
                  notice: 'Invoice email template was successfully created.'
    else
      render :new
    end
  end

  def update
    if @invoice_email_template.update(invoice_email_template_params)
      redirect_to @invoice_email_template, \
                  notice: 'Invoice email template was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @invoice_email_template.destroy

    redirect_to invoice_email_templates_url, \
                notice: 'Invoice email template was successfully destroyed.'
  end

  private

  def set_invoice_email_template
    @invoice_email_template = current_user.invoice_email_templates
                              .find(params[:id])
  end

  def invoice_email_template_params
    params.require(:invoice_email_template).permit([
      :template_subject,
      :template_body,
      :name
    ])
  end
end
