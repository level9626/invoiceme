class DashboardController < ApplicationController
  def show
    @company = current_user.companies.default
  end
end
