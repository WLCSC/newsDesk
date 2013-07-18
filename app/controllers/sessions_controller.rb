require 'auth.rb'

class SessionsController < ApplicationController
	skip_before_filter :check_for_user
	def new
	end

	def create
		params[:username].downcase!
		user = User.where(:username => params[:username]).first
		if APP_CONFIG[:auth_ldap] && (!user || (user && user.password_hash == nil))
			lgi = ldap_login(params[:username], params[:password])
			if lgi && lgi.length > 0
				user = ldap_populate(params[:username], params[:password], user)
				session[:user_id] = user.id
				flash[:notice] = "Logged in!"
				redirect_to root_path
			else
				flash[:alert] = "Invalid login."
				redirect_to root_path 
			end
		elsif APP_CONFIG[:auth_local] && user && user.email_address != nil
			if user.password_hash == BCrypt::Engine.hash_secret(params[:password], user.password_salt)
				session[:user_id] = user.id
				flash[:notice] = "Logged in!"
				redirect_to root_path
			else
				flash[:alert] = "Invalid local login."
				redirect_to root_path

			end
		else
			flash[:alert] = "You are not allowed to log in."
			redirect_to root_path
		end
		
	end

	def destroy
		session[:user_id] = nil  
		redirect_to root_url, :notice => "Logged out!"  
	end
end
