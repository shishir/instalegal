class ClientsController < ApplicationController
  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      flash[:success] = "Welcome #{@client.name}"
      self.current_user = @client
      redirect_to root_path
    else
      render 'clients/new'
    end
  end
end
