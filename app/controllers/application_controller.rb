class ApplicationController < ActionController::Base


  protect_from_forgery with: :exception

  before_action :authenticated

  def authenticated
  	unless session[:user_id].present?
  		redirect_to :login
  	end
  end

  def guest
  	if session[:user_id].present?
  		redirect_to :root
  	end
  end

  def current_user
  	if is_authenticated
  		return User.find session[:user_id]
  	end
  end

  def is_authenticated
  	session[:user_id].present?
  end

  def is_guest
  	session[:user_id].blank?
  end

  helper_method :is_authenticated, :is_guest, :current_user

end
