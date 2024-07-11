class HostesController < ApplicationController
    def new
        @hoste = Hoste.new
    end

    def show
        @hoste = Hoste.find(params[:id])
        @vehicles = @hoste.vehicles.paginate(page: params[:page], per_page: 10)
    end

    def index
        @hostes = Hoste.paginate(page: params[:page], per_page: 10)     
    end
    
    

    def create
        @hoste = Hoste.new(hoste_params)
        if @hoste.save
            session[:hoste_id] = @hoste.id
            redirect_to root_path, notice: "Successfully created account as Host"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @hoste = Hoste.find(params[:id])
    end

    def update
        @hoste = Hoste.find(params[:id])
        if @hoste.update(hoste_params)
            redirect_to root_path, notice: "Your account information was successfully updated"
        else
            render :edit, status: :unprocessable_entity
        end       
    end
    
    private

    def hoste_params
        params.require(:hoste).permit(:host_full_name, :email, :phone, :password, :password_confirmation, :no_of_cars)
    end
end
