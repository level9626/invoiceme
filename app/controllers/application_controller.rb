class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :get_layout!

  protected

  def get_layout!
    signed_in? ? 'authenticated' : 'application'
  end
end
