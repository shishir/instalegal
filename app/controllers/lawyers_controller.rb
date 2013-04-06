class LawyersController < ApplicationController
  def new
    @lawyer = Lawyer.new
  end

  def create
    @lawyer = Lawyer.new(params[:lawyer])
    if @lawyer.save
      flash[:success] = "Welcome #{@lawyer.name}"
      self.current_user = @lawyer
      redirect_to root_path
    else
      render 'lawyers/new'
    end
  end

  def index
    @lawyers = Lawyer.all
  end
end
