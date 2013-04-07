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
      current_user.create_opentok_session(request.remote_addr)
      redirect_to lawyer_path(current_user)
     end
   else
     flash[:error] = "We couldn't find a user with the supplied credentials"
     render 'sessions/new'
   end
  end

  def generate_token
    token_id = current_user.generate_token(params[:opentok_session_id])
    render json: {token_id: token_id}
  end

  def destroy
    self.current_user = nil
    flash[:notice] = "Signed out"
    redirect_to root_path
  end
end