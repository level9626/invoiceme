class ProfilesController < ApplicationController
  def profile
    @company = current_user.companies.default
  end
end