class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do
  	redirect_to accounts_path,alert:"You are not allowed to access this page"
  end


  helper_method :current_account 

  helper_method :all_accounts


  def current_account    
    @current_account = Account.find(session[:account]) if session[:account]
  end

  def all_accounts
    @all_accounts ||= Account.all
  end

  # def all_companies
  #   @all_companies ||= Company.all
  # end

end
