class InvoiceMailsController < ApplicationController
  before_action :_set_invoice_mail, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @search = _search
    @invoice_mails = @search.result.paginate(per_page: 10, page: params[:page])
    respond_to do |format|
      format.html
      format.csv { send_data @invoice_mails.to_csv }
    end
  end

  def show
  end

  def new
    @invoice_mail = InvoiceMail.new
    respond_with(@invoice_mail)
  end

  def edit
  end

  def create
    @invoice_mail = current_user.invoice_mails.new(invoice_mail_params)
    @invoice_mail.invoice_id = params[:invoice_id]
    if @invoice_mail.save
      flash[:notice] = 'Invoice Mail was successfully send.'
      # TODO: catch errors
      # TODO: move publish and email sending to service
      InvoiceMailer.invoice_mail(@invoice_mail).deliver
      # publish invoice
      @invoice_mail.invoice.publish unless @invoice_mail.invoice.open?
    else
      flash[:error] = 'Invoice Mail was not successfully created.'
    end
    redirect_to :back
  end

  def update
    if @invoice_mail.update(invoice_mail_params)
      flash[:notice] = 'InvoiceMail was successfully updated.'
      respond_with(@invoice_mail)
    else
      flash[:error] = 'InvoiceMail was not successfully updated.'
      redirect_to :back
    end
  end

  def destroy
    @invoice_mail.destroy
    respond_with(@invoice_mail)
  end

  private

  def _search
    @invoice = Invoice.find(params[:invoice_id])
    _collection.search(params[:q])
  end

  def _set_invoice_mail
    @invoice_mail = _collection.find(params[:id])
    @invoice = Invoice.find(params[:invoice_id])
  end

  def _collection
    current_user.invoice_mails.where(invoice_id: params[:invoice_id])
  end

  def invoice_mail_params
    params.require(:invoice_mail).permit([
      :invoice_id,
      :to,
      :subject,
      :cc,
      :body,
      :invoice_email_template_id,
      :attachment
    ])
  end
end
