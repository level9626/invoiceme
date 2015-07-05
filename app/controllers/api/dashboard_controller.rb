module Api
  class DashboardController < ApplicationController
    def show
      @company = current_user.companies.default
      @invoices = current_user.invoices.order(:updated_at).limit(5)
    end
  end
end
