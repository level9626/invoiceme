class InvoiceMailsController < ApplicationController
  before_action :set_invoice_mail, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @invoice_mails = cueent_user.invoice_mails.all
    respond_with(@invoice_mails)
  end

  def show
    respond_with(@invoice_mail)
  end

  def new
    @invoice_mail = InvoiceMail.new
    respond_with(@invoice_mail)
  end

  def edit
  end

  # rubocop:disable all
  def create
    @invoice_mail = current_user.invoice_mails.new(invoice_mail_params)
    @invoice_mail.to = invoice_mail_params['to'].split(',').map(&:strip)
    @invoice_mail.cc = invoice_mail_params['cc'].split(',').map(&:strip)

    if @invoice_mail.save
      flash[:notice] = 'Invoice Mail was successfully send.'
      # TODO: catch errors
      # TODO: move publish and email sending to service
      InvoiceMailer.invoice_mail(@invoice_mail).deliver
      # publish invoice
      @invoice_mail.invoice.publish
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

  def set_invoice_mail
    @invoice_mail = current_user.invoice_mails.find(params[:id])
  end

  def invoice_mail_params
    params.require(:invoice_mail).permit([
      :invoice_id,
      :to,
      :subject,
      :cc,
      :body,
      :invoice_email_template_id
    ])
  end
end
