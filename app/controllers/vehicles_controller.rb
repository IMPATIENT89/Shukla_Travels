class VehiclesController < ApplicationController

    def new
      @vehicle = Vehicle.new
    end

    def show
      @vehicle = Vehicle.find(params[:id])
      @bookings = @vehicle.bookings.all
    end

    def index
      @vehicles = Vehicle.all
    end
    
    def create
        @vehicle = Vehicle.new(vehicle_params)
        @vehicle.hoste = current_host
        if @vehicle.save
          redirect_to @vehicle, notice: "Your vehicle is successfully registered"
        else
          render :new, status: :unprocessable_entity
        end
    end

    def edit
      @vehicle = Vehicle.find(params[:id])
    end
    
    def update
      @vehicle = Vehicle.find(params[:id])
      if @vehicle.update(vehicle_params)
          redirect_to @vehicle, notice: "Your vehicle  was successfully updated"
      else
          render :edit, status: :unprocessable_entity
      end  
    end

    def destroy
      @vehicle = Vehicle.find(params[:id])
      @vehicle.destroy
      redirect_to vehicles_path, notice: "Your vehicle was successfully deleted"  
    end
    
    private

    def vehicle_params
        params.require(:vehicle).permit(:vehicle_no, :registration_no, :no_of_seats, :car_name)
    end
    
end
