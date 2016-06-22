class SessionsController < ApplicationController
    def new
    end

    def create
      user = User.find_by_username(params[:username])
      if user && User.authenticate(params[:username], params[:password])
        session[:user_id] = user.id
        redirect_to '/home', notice: "You are logged into the Project Chuck system"
      else
        flash[:message] = "Username or password is invalid"
        render "new"
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to home_path, notice: "Logged out!"
    end
  end