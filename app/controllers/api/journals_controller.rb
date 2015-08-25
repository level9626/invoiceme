module Api
  class JournalsController < ApplicationController
    respond_to :json
    def index
      @journals = current_user.invoices.find(params[:invoice_id]).journals
    end
  end
end
