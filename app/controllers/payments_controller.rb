class PaymentsController < ApplicationController
  before_action :_set_payment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @search = _search

    @payments = @search.result.paginate(per_page: 10, page: params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @payments.to_csv }
    end
  end

  def show
    respond_with(@payment)
  end

  def new
    @payment = Payment.new
    respond_with(@payment)
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.save
    redirect_to :back
  end

  def update
    @payment.update(payment_params)
    respond_with(@payment)
  end

  def destroy
    @payment.destroy
    respond_with(@payment)
  end

  private

  def _search
    Payment.joins(:invoice)
      .includes(:client, :company)
      .where(invoices: { user_id: current_user.id })
      .search(params[:q])
  end

  def _set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:invoice_id, :currency, :amount)
  end
end
