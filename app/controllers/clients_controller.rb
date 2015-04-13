class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @clients = current_user.clients
    respond_with(@clients)
  end

  def show
    respond_with(@client)
  end

  def new
    @client = Client.new()
    respond_with(@client)
  end

  def edit
  end

  def create
    @client = Client.new(client_params)
    @client.clients_users.build(user_id: current_user.id)
    @client.save
    respond_with(@client)
  end

  def update
    @client.update(client_params)
    respond_with(@client)
  end

  def destroy
    @client.destroy
    respond_with(@client)
  end

  private
    def set_client
      @client = current_user.clients.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name, :address)
    end
end
