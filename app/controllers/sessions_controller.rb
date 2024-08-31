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

    def create_via_google
        auth = request.env['omniauth.auth']
        email = auth.info['email']
        name = auth.info['name']
        image_url = auth.info['image'] # The URL of the GitHub user's profile image
    
        # Find or create the customer by email
        @customer = Customer.find_or_create_by!(email: email) do |customer|
          customer.password = "123456"
          customer.customer_full_name = name
          # Download and attach the profile image using Active Storage
          customer.profile_image.attach(io: URI.open(image_url), filename: "profile_image.jpg") if image_url
        end
  
        if @customer.persisted?
          session[:customer_id] = @customer.id
          redirect_to @customer, notice: "Logged In Successfully"
          
        else
          redirect_to root_path
        end
    end
    
    def destroy
        session[:customer_id] = nil
        redirect_to root_path, notice: "Logged Out"
    end
    
end
