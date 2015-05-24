class InvoiceEmailTemplatesController < ApplicationController
  before_action :_get_parent
  before_action :_set_invoice_email_template, \
                only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @search = _search
    @invoice_email_templates = @search.result
                               .paginate(per_page: 10, page: params[:page])
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
    @invoice_email_template = @parent.mail_templates
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

  def _set_invoice_email_template
    @invoice_email_template = @parent.mail_templates.find(params[:id])
  end

  def invoice_email_template_params
    params.require(:invoice_email_template).permit([
      :template_subject,
      :template_body,
      :name,
      :cc,
      :to,
      :from
    ])
  end

  def _search
    @parent.mail_templates.search(params[:q])
  end

  def _get_parent
    @parent = Client.find_by(id: params[:client_id]) || current_user
  end
end
