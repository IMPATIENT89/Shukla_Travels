class HostsController < ApplicationController
    def new
        @host = Host.new
    end

    def show
        @host = Host.find(params[:id])
        @vehicles = @host.vehicles.all
    end

    def index
        @hosts = Host.all     
    end
    
    def create
        @host = Host.new(host_params)
        if @host.save
            session[:host_id] = @host.id
            redirect_to root_path, notice: "Successfully created account as Host"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @host = Host.find(params[:id])
    end

    def update
        @host = Host.find(params[:id])
        if @host.update(host_params)
            redirect_to root_path, notice: "Your account information was successfully updated"
        else
            render :edit, status: :unprocessable_entity
        end       
    end
    
    private

    def host_params
        params.require(:host).permit(:host_full_name, :email, :phone, :password, :password_confirmation, :no_of_cars)
    end
end
