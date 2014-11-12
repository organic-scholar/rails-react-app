class AuthController < ApplicationController

	before_action :authenticated, :only => [:logout]

	before_action :guest, :only => [:show, :login]

	def show
		render 'login'
	end

	def login
		user = User.find_by_username params[:username]
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			return redirect_to :root
		end
		render :show
	end

	def logout
		session.delete :user_id
		redirect_to :login
	end

end
