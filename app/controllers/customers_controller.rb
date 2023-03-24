class CustomersController < ApplicationController


    def new
        @customer = Customer.new
    end

    def show
        @customer = Customer.find(params[:id])
        @bookings = @customer.bookings.paginate(page: params[:page], per_page: 2)
    end
    
    def index
        @customers = Customer.paginate(page: params[:page], per_page: 10)
    end
    
    def create
        @customer = Customer.new(customer_params)
        if @customer.save
            session[:customer_id] = @customer.id
            redirect_to @customer, notice: "Successfully created account. Now, plase login with your credentials"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @customer = Customer.find(params[:id])
    end

    def update
        @customer = Customer.find(params[:id])
        if @customer.update(customer_params)
            redirect_to customer, notice: "Your account information was successfully updated"
        else
            render :edit, status: :unprocessable_entity
        end       
    end

    private

    def customer_params
        params.require(:customer).permit(:customer_full_name, :email, :phone, :password, :password_confirmation)
    end

    

end
