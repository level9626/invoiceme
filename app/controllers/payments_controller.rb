class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @search   = current_user.payments
                            .includes(:client, :invoice, :company)
                            .search(params[:q])
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
    respond_with(@payment)
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
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:invoice_id, :amount)
    end
end
