class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def login
	end

	def new
		@user = User.new
	end

	def post_login
		@current_user = User.find_by login: params[:login]

		if @current_user!= nil && @current_user.password_valid?(params[:password])
			session[:userid] = @current_user.id
			session[:first_name] = @current_user.first_name
			redirect_to(:controller => 'photos', :action => 'index', :id => @current_user.id)		
		else
			flash[:notice] = "Invalid Username/Password!"
			redirect_to(:action => 'login')
		end
	end

	def logout
		session[:userid] = nil
		session[:first_name] = nil
		render(:action => :login)
	end

	def create
		if params[:user][:password].empty? == true
			flash[:notice] = "Please Input a password!"
			redirect_to(:action => 'new')
			return
		end

		if params[:user][:password] != params[:user][:retyped]
			flash[:notice] = "Please make sure the passwords match!"
			redirect_to(:action => 'new')
			return
		end

		@existing_user = User.find_by login: params[:user][:login].downcase
		if @existing_user != nil
			flash[:notice] = "User: #{params[:user][:login]} Already Exists!"
			redirect_to(:action => 'new')
			return
		end

		@user = User.new
		@user.first_name = params[:user][:first_name]
		@user.last_name = params[:user][:last_name]
		@user.login = params[:user][:login]
		@user.password= (params[:user][:password])
		if @user.save() then
			redirect_to(:action => 'login')
		else
			flash[:notice] = @user.errors.messages
			redirect_to(:action => 'new')
		end
	end

end
