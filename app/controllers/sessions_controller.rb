class SessionsController < ApplicationController
    def new
        
    end
    
    def create
        customer = Customer.find_by(email: params[:email])
        if customer && customer.authenticate(params[:password])
            session[:customer_id] = customer.id
            redirect_to customer, notice: "Logged In Successfully"
        else
            flash.now[:alert] = "There was something wrong with your login details"
            render :new, status: :unprocessable_entity
        end
    end
    
    def destroy
        session[:customer_id] = nil
        redirect_to root_path, notice: "Logged Out"
    end
    
end
