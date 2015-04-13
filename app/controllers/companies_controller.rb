class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html, :json

  def index
    @companies = current_user.companies.all
    respond_with(@companies)
  end

  def show
    respond_with(@company)
  end

  def new
    @company = Company.new
    respond_with(@company)
  end

  def edit
  end

  def create
    @company = Company.new(company_params.merge(user_id: current_user.id))
    @company.save
    respond_with(@company)
  end

  def update
    @company.update(company_params)
    respond_with(@company)
  end

  def destroy
    @company.destroy
    respond_with(@company)
  end

  private
    def set_company
      @company = current_user.companies.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:logo, :name, :address)
    end
end
