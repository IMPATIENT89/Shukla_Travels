class SessionsHostController < ApplicationController
    def new
        
    end
    
    def create
        hoste = Hoste.find_by(email: params[:email])
        if hoste && hoste.authenticate(params[:password])
            session[:hoste_id] = hoste.id
            redirect_to hoste, notice: "Logged In Successfully As Host"
        else
            flash.now[:alert] = "There was something wrong with your login details"
            render :new, status: :unprocessable_entity
        end
    end
    
    def destroy
        session[:hoste_id] = nil
        redirect_to root_path, notice: "Logged Out"
    end
end
