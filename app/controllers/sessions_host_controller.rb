class SessionsHostController < ApplicationController
    def new
        
    end
    
    def create
        host = Host.find_by(email: params[:email])
        if host && host.authenticate(params[:password])
            session[:host_id] = host.id
            redirect_to host, notice: "Logged In Successfully As Host"
        else
            flash.now[:alert] = "There was something wrong with your login details"
            render :new, status: :unprocessable_entity
        end
    end
    
    def destroy
        session[:host_id] = nil
        redirect_to root_path, notice: "Logged Out"
    end
end
