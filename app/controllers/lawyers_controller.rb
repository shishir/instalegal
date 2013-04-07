class LawyersController < ApplicationController
  def new
    @lawyer = Lawyer.new
  end

  def create
    @lawyer = Lawyer.new(params[:lawyer])
    if @lawyer.save
      flash[:success] = "Welcome #{@lawyer.name}"
      self.current_user = @lawyer
      @lawyer.create_opentok_session(request.remote_addr)
      redirect_to lawyer_path(current_user)
    else
      render 'lawyers/new'
    end
  end

  def index
    @lawyers = Lawyer.all
  end

  def busy
    @lawyer = Lawyer.find(params[:id])
    @lawyer.mark_busy
    head :ok
  end

  def available
    @lawyer = Lawyer.find(params[:id])
    @lawyer.mark_available
    head :ok
  end
end
