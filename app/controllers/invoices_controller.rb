class InvoicesController < ApplicationController
  before_action :_set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :_verify_company!, only: [:new]

  respond_to :html

  def index
    @search = _search
    @invoices = @search.result.paginate(per_page: 10, page: params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @invoices.to_csv }
    end
  end

  def show
    commontator_thread_show(@invoice)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'file',
               template: 'invoices/_show_content.html.slim',
               zoom: 0.9,
               layout: 'pdf_layout'
      end
    end
  end

  def new
    @invoice = current_user.invoices.new
    @invoice.invoice_items.build
    respond_with(@invoice)
  end

  def edit
  end

  def create
    @invoice = current_user.invoices.new(invoice_params)
    @invoice.save
    respond_with(@invoice)
  end

  def update
    @invoice.update(invoice_params)
    respond_with(@invoice)
  end

  def destroy
    @invoice.destroy
    respond_with(@invoice)
  end

  private

  def _search
    Invoice.where(user: current_user)
      .includes(:client)
      .search(params[:q])
  end

  def _set_invoice
    @invoice = current_user.invoices.find(params[:id])
  end

  def _verify_company!
    return unless current_user.companies.empty?

    flash[:notice] = "You'll need to create a company first!"
    redirect_to new_company_path
  end

  # rubocop:disable all
  def invoice_params
    params.require(:invoice).permit([
      :invoice_number,
      :invoice_date,
      :currency,
      :comment,
      :company_row_text,
      :client_row_text,
      :company_id,
      :client_id,
      :subtotal,
      :vat_rate,
      :vat,
      :discount,
      invoice_items_attributes: [
        :description,
        :hours_or_tasks,
        :rate,
        :_destroy,
        :amount
      ]
    ])
  end
  # rubocop:enable all
end
