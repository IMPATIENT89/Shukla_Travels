class BookingsController < ApplicationController

    before_action :require_customer_login

    def new
        @booking = Booking.new
        @vehicles = Vehicle.all
    end

    def show
        @booking = Booking.find(params[:id])
    end
  
    def index
      @bookings = Booking.all
    end

    def create
        @vehicles = Vehicle.all
        @booking = Booking.new(booking_params)
        @booking.customer = current_customer
        if @booking.save
          @stripe_service = StripeService.new
          @customer = current_customer
          @payment_method = @stripe_service.create_payment_method(payment_method_params)
          @stripe_customer = @stripe_service.find_or_create_customer(@customer, @payment_method.id)
          @amount_to_be_paid = 1000
          @payment_intent = @stripe_service.create_stripe_payment_intent(@amount_to_be_paid, @stripe_customer.id , @payment_method.id, @booking)

          @booking.update(
          customer_id: @customer.id,
          stripe_transaction_id: @payment_intent.id,
          amount_paid: @amount_to_be_paid
          )
          BookingMailer.booking_confirmation(@booking).deliver_now
          redirect_to @booking, notice: "Booking is done"
        else
          render :new, status: :unprocessable_entity, alert: "Something went wrong. Please check your Internet Connection or please refresh the page and continue again"
        end
    end

    def edit
      @booking = Booking.find(params[:id])
      @vehicles = Vehicle.all
    end

  def update
      @booking = Booking.find(params[:id])
      if @booking.update(booking_params)
          redirect_to @booking, notice: "Your trip was successfully updated"
      else
          render :edit, status: :unprocessable_entity
      end       
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: "Your trip was successfully deleted"
  end
    
    private

    def booking_params
      params.require(:booking).permit(:how_many_people, :booking_from, :booking_to, :booking_date, :choose_car, :vehicle_id)
    end
    
    def payment_method_params
      params.require(:booking).permit(:card_number, :exp_month, :exp_year, :cvv)
    end

    def require_customer_login
      unless logged_in_as_customer?
        flash[:alert] = "Please log in to continue the booking."
        redirect_to sign_in_customer_path
      end
    end
end
