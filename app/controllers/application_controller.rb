class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  after_filter :store_location

  before_action :better_errors_hack, if: -> { Rails.env.development? }
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit
  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def better_errors_hack
    request.env['puma.config'].options.user_options.delete :app
  end

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

  def configure_permitted_parameters
    ## To permit attributes while registration i.e. sign up (app/views/devise/registrations/new.html.erb)
    devise_parameter_sanitizer.permit(:sign_up, keys:[:first_name, :last_name])

    ## To permit attributes while editing a registration (app/views/devise/registrations/edit.html.erb)
    devise_parameter_sanitizer.permit(:account_update, keys:[:first_name, :last_name])
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

end
