module Api
  class JournalsController < ApplicationController
    before_action :_set_journal, only: [:index]

    ## Responce formats
    respond_to :json

    def index
      @search = _search
      @journals = @search.result.paginate(per_page: 20, page: params[:page])
    end

    private

    def _search
      current_user.invoices.find(params[:invoice_id]).journals.search(params[:q])
    end

    def _set_journal
      @journals = current_user.invoices.find(params[:invoice_id]).journals
    end
  end
end
