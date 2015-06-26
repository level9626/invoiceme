class InvoicesController < ApplicationController # rubocop:disable ClassLength
  ## Controller filters
  before_action :_set_invoice, only: [:show, :edit, :update, :destroy] + \
    Invoice.state_machines[:state].events.map(&:name)
  before_action :_verify_company!, only: :new

  ## Defining layout
  layout :_invoice_layout

  ## Responce formats
  respond_to :html, :json

  ## Crud methods
  def index
    @search = _search
    @invoices = @search.result.paginate(per_page: 10, page: params[:page])
    respond_to do |format|
      format.html
      format.csv { send_data @invoices.to_csv }
    end
  end

  def show
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

  def create
    @invoice = current_user.invoices.new(invoice_params)
    # redirect back to show page, and show errors if any
    @invoice.save
    respond_with(@invoice)
  end

  def update
    @invoice.update(invoice_params)
    # redirect back to show page, and show errors if any
    render :show, layout: 'show_layout'
  end

  def destroy
    @invoice.destroy
    respond_with(@invoice)
  end

  ## Custom member actions

  # States
  Invoice.state_machines[:state].events.map(&:name).each do |event|
    define_method event do
      @invoice.send(event)
      redirect_to :back
    end
  end

  # Statistics and metrics
  def statistics
    @statistics = {}
    @statistics[:count] = Invoice.count_by_currency current_user
    @statistics[:overdue_count] = Invoice.overdue_count_by_currency current_user

    respond_with(@statistics)
  end

  ## Private Scope

  private

  def _search
    current_user.invoices
      .includes(:journals, :company, :client, :invoice_items, :payments)
      .search(params[:q])
  end

  def _set_invoice
    @invoice = current_user.invoices
               .unscoped
               .eager_load(:journals, :company, :client, \
                           :invoice_items, :payments)
               .find(params[:id])
  end

  def _verify_company!
    return unless current_user.companies.empty?

    flash[:notice] = "You'll need to create a company first!"
    redirect_to new_company_path
  end

  def _invoice_layout
    return 'show_layout' if %w(show new create).include?(action_name)
    'authenticated'
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
      :net,
      invoice_items_attributes: [
        :id,
        :description,
        :hours_or_tasks,
        :rate,
        :_destroy,
        :amount
      ],
      attachments_attributes: [
          :id,
          :file,
          :_destroy
      ]
    ])
  end
  # rubocop:enable all
end
