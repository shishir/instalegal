class SessionsController < ApplicationController
  def new
  end

  def create
   user = User.where(email: params[:email], password: params[:password]).first
   if user
     self.current_user = user
     flash[:success] = "Welcome #{user.name}"
     if user.type == "Client"
       redirect_to lawyers_path
    else
      redirect_to root_path
    end
   else
     flash[:error] = "We couldn't find a user with the supplied credentials"
     render 'sessions/new'
   end
  end

  def destroy
     self.current_user = nil
     flash[:notice] = "Signed out"
     redirect_to root_path
   end
end