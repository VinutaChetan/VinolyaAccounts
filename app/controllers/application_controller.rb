class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do
  	redirect_to accounts_path,alert:"You are not allowed to access this page"
  end
before_action :configure_devise_permitted_parameters, if: :devise_controller?

  helper_method :current_account 

  helper_method :all_accounts

  helper_method :all_companies


  def current_account  
      @current_account = Account.find(session[:account]) if session[:account]
  end

  def all_accounts
    @all_accounts ||= Account.all
  end

  def all_companies
    @all_companies ||= Company.includes(:accounts)
  end

  protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:userid])
  # end

   def configure_devise_permitted_parameters
  registration_params = [:userid]

  if params[:action] == 'create'
    devise_parameter_sanitizer.for(:sign_up) do
      |u| u.permit(registration_params)
    end
  end
end

end
