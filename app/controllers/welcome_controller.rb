class WelcomeController < ApplicationController
  def index
    @homepage=true
    redirect_to lawyers_path  if current_user
  end
end
