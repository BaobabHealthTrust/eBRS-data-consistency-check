class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery #with: :exception
  
  before_filter :perform_basic_auth, :except => ['login']


  private

  def perform_basic_auth
    if session[:user_id].blank?
      redirect_to '/login' and return
    else
      User.current = User.find(session[:user_id])
    end
  end

end
