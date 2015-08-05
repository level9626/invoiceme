module Api
  class CompaniesController < ApplicationController
    before_action :_set_company, only: [:show, :edit, :update, :destroy]

    respond_to :json

    def index
      @search = _search
      @companies = @search.result.paginate(per_page: 10, page: params[:page])
    end

    def show
    end

    def create
      @company = Company.new(company_params.merge(user_id: current_user.id))
      try_respond_with(@company)
    end

    def update
      @company.update(company_params)
      respond_with(@company)
    end

    def destroy
      @company.destroy
      respond_with(@company)
    end

    # Custom actions

    def default
      @company = current_user.companies.default
      respond_to do |format|
        format.json { render template: 'api/companies/show.json' }
      end
    end

    private

    def _search
      current_user.companies.search(params[:q])
    end

    def _set_company
      @company = current_user.companies.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:logo, :name, :email, :address, :default)
    end
  end
end
