class InvoiceEmailTemplatesController < ApplicationController
  before_action :_load_template_parent
  before_action :_set_invoice_email_template, \
                only: [:show, :edit, :update, :copy, :destroy]

  respond_to :html, :json

  def index
    @search = _search
    @invoice_email_templates = @search.result
                               .paginate(per_page: 10, page: params[:page])
    respond_to do |format|
      format.html
      format.csv { send_data @invoice_email_templates.to_csv }
    end
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
    @invoice_email_template = @template_parent.mail_templates
                              .new(invoice_email_template_params)

    if @invoice_email_template.save
      redirect_to [@template_parent, :invoice_email_templates], \
                  notice: 'Invoice email template was successfully created.'
    else
      render :new
    end
  end

  def copy
    @invoice_email_template = InvoiceEmailTemplate.find(params[:id]).dup
    @invoice_email_template.default = false
    @invoice_email_template.name = @invoice_email_template.name + ' (copy)'
    render :new
  end

  def update
    if @invoice_email_template.update(invoice_email_template_params)
      redirect_to [@template_parent, :invoice_email_templates], \
                  notice: 'Invoice email template was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    return if @invoice_email_template.default
    @invoice_email_template.destroy
    redirect_to [@template_parent, :invoice_email_templates], \
                notice: 'Invoice email template was successfully destroyed.'
  end

  private

  def _set_invoice_email_template
    @invoice_email_template = @template_parent.mail_templates.find(params[:id])
  end

  # rubocop:disable all
  def invoice_email_template_params
    params.require(:invoice_email_template).permit([
      :template_subject,
      :template_body,
      :name,
      :cc,
      :to,
      :from,
      :primary,
      attachments_attributes: [
          :id,
          :file,
          :_destroy
      ]
    ])
  end
  # rubocop:enable all

  def _search
    @template_parent.mail_templates.search(params[:q])
  end

  def _load_template_parent
    resource, id = request.path.split('/')[1, 2]
    @template_parent = resource.singularize.classify.constantize.find(id)
  end
end
