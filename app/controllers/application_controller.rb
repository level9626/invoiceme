# All controllers will inherit from this one
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :_get_layout

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def authenticate_admin_user!
    authenticate_user!
    redirect_to new_user_session_path unless current_user.admin?
  end

  # For Angular.js
  def index
    render text: '', layout: true
  end

  protected

  def _get_layout
    signed_in? ? 'authenticated' : 'application'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  # We Only need locals for errors.
  # It in impossible to pass, as locals, and instance variable
  # So places where we need send back json/show partials, system
  # will rely, on the developer, to declare instance variable
  # prior to executing try_respond_with method.
  def try_respond_with(obj)
    name = obj.class.to_s.underscore
    params =  if obj.save
                { template: "api/#{name.pluralize}/show.json",
                  status:   200 }
              else
                { template: 'api/shared/errors.json',
                  status:   422,
                  locals:  { errors: obj.errors } }
              end
    render params
  end
end
