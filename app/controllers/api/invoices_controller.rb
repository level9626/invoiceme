module Api
  class InvoicesController < ApplicationController # rubocop:disable ClassLength
    ## Controller filters
    before_action :_set_invoice, only: [:show, :edit, :update, :destroy] + \
      Invoice.state_machines[:state].events.map(&:name)
    before_action :_verify_company!, only: :new

    ## Defining layout
    layout :_invoice_layout

    ## Responce formats
    respond_to :json

    ## Crud methods
    def index
      @search = _search
      @invoices = @search.result.paginate(per_page: 10, page: params[:page])
    end

    def show
      respond_to do |format|
        format.json { render template: 'api/invoices/show.json'}
        format.pdf do
          render pdf: 'file',
                 template: 'invoices/_show_content.html.slim',
                 zoom: 0.9,
                 layout: 'pdf_layout'
        end
      end
    end

    def create
      @invoice = current_user.invoices.new(invoice_params)
      # redirect back to show page, and show errors if any
      try_respond_with(@invoice)
    end

    def update
      @invoice.update(invoice_params)
      # redirect back to show page, and show errors if any
      try_respond_with(@invoice)
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

    def states
      respond_with(Invoice.select('distinct state').all.map(&:state))
    end

    # Statistics and metrics
    def statistics
      respond_with(current_user.invoices.profile_statistics)
    end

    # Returns valid for user invoice number for user
    def invoice_number
      respond_with({invoice_number: current_user.invoices.new.invoice_number})
    end

    # Returns count of invoices for a particular user
    def invoice_count
      respond_with({invoice_count: current_user.invoices.count})
    end

    ## Private Scope

    private

    def _search
      current_user.invoices
        .includes(:company, :client, :invoice_items, :payments)
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
      params.require(:invoice)
        .remove_nulls
        .tap { |whitelisted|
          if params[:invoice].has_key? :invoice_items
            whitelisted[:invoice_items_attributes] = \
              params[:invoice][:invoice_items]
          end
          if params[:invoice].has_key? :attachments
            whitelisted[:attachments_attributes] = \
              params[:invoice][:attachments]
          end
        }.permit([
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
end
