module Api
  class ProfilesController < ApplicationController
    respond_to :json

    def percent_payed
      respond_with(current_user.percent_payed.round(2))
    end
  end
end
