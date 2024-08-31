class BookingsController < ApplicationController
  before_action :require_customer_login, only: [:new, :create, :edit, :update, :destroy, :upi_payment, :payment_success, :index]
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :upi_payment, :payment_success]

  def new
    @booking = Booking.new
    @vehicles = Vehicle.all
    @bookings_count = current_customer.bookings.count # Adjust this based on your actual association
    begin
      payment_service = RazorpayService.new(current_customer, nil, nil)
      payment_service.find_or_create_customer
    rescue StandardError => e
      Rails.logger.error "Failed to create Razorpay customer: #{e.message}"
    end
  end

  def show
    begin
      @razorpay_service = RazorpayService.new(current_customer, nil, @booking)
      @order_status = @razorpay_service.find_order_status
      if @order_status == "paid" && @booking.payment_mode == "upi"
        @booking.update!(payment_status: 'completed')
      end
    rescue StandardError => e
      Rails.logger.error "Failed to fetch order: #{e.message}"
    end
  
    # Add this line to set a flag for auto-refresh
    @auto_refresh = @booking.payment_mode == "upi" && @booking.payment_status != 'completed'
  end

  def index
    @bookings = current_customer.bookings.order(created_at: :desc)
  end  

  def create
    @vehicles = Vehicle.all
    @booking = Booking.new(booking_params)
    @booking.customer = current_customer
    
    @amount_to_be_paid = (@booking.amount_paid).to_i

    case @booking.payment_mode
    when 'card'
      process_card_payment
    when 'upi'
      process_upi_payment
    else
      process_cash_payment
    end
  end

  def edit
    @vehicles = Vehicle.all
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: "Your trip was successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end       
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path, notice: "Your trip was successfully deleted"
  end

  def payment_success
    # Verify the payment signature here
    if verify_razorpay_signature
      @booking.update(payment_status: 'completed')
      redirect_to @booking, notice: "Payment successful! Your booking is confirmed."
    else
      @booking.update(payment_status: 'failed')
      redirect_to @booking, alert: "Payment verification failed. Please contact support."
    end
  end
    
  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def process_card_payment
    @stripe_service = StripeService.new
    @customer = current_customer
    @payment_method = @stripe_service.create_payment_method(payment_method_params)
    @stripe_customer = @stripe_service.find_or_create_customer(@customer, @payment_method.id)
    
    begin
      @payment_intent = @stripe_service.create_stripe_payment_intent(@amount_to_be_paid, @stripe_customer.id, @payment_method.id, @booking)
      if @booking.save
        @booking.update(
          stripe_transaction_id: @payment_intent.id,
          amount_paid: @amount_to_be_paid,
          payment_status: 'completed'
        )
        send_confirmation_and_redirect
      else
        @stripe_service.cancel_payment_intent(@payment_intent.id) if @payment_intent
        render :new, status: :unprocessable_entity, alert: "Unable to save booking. Please try again."
      end
    rescue => e
      handle_payment_error(e)
    end
  end

  def process_upi_payment
    begin
      @razorpay_service = RazorpayService.new(current_customer, @amount_to_be_paid, @booking)
      @order_id = @razorpay_service.create_order
  
      if @booking.save
        @booking.update(
          order_id: @order_id,
          amount_paid: @amount_to_be_paid,
          payment_status: 'pending'
        )
        redirect_to @booking, notice: "Please make the Payment!"
      else
        render :new, status: :unprocessable_entity, alert: "Unable to save booking. Please try again."
      end
    rescue Razorpay::Error => e
      Rails.logger.error("Razorpay Error: #{e.message}")
      flash[:alert] = "Payment processing error. Please try again later."
      render :new, status: :unprocessable_entity
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Database Error: #{e.message}")
      flash[:alert] = "Unable to save booking. Please try again later."
      render :new, status: :unprocessable_entity
    rescue StandardError => e
      Rails.logger.error("General Error: #{e.message}")
      flash[:alert] = "An unexpected error occurred. Please try again later."
      render :new, status: :unprocessable_entity
    end
  end
  

  def process_cash_payment
    if @booking.save
      @booking.update(
        amount_paid: @amount_to_be_paid,
        payment_status: 'pending'
      )
      send_confirmation_and_redirect
    else
      render :new, status: :unprocessable_entity, alert: "Unable to save booking. Please try again."
    end
  end

  def send_confirmation_and_redirect
    BookingMailer.booking_confirmation(@booking).deliver_now
    redirect_to @booking, notice: "Booking is confirmed"
  end

  def handle_payment_error(error)
    Rails.logger.error "Error in booking creation: #{error.message}"
    @booking.errors.add(:base, "An error occurred while processing your payment. Please try again.")
    render :new, status: :unprocessable_entity, alert: "An error occurred while processing your payment. Please try again."
  end

  def verify_razorpay_signature
    @razorpay_service = RazorpayService.new(current_customer, @booking.amount_paid, @booking)
    @razorpay_service.verify_payment_signature(params[:razorpay_payment_id], params[:razorpay_order_id], params[:razorpay_signature])
  end

  def booking_params
    params.require(:booking).permit(:how_many_people, :booking_from, :booking_to, :booking_date, :choose_car, :vehicle_id, :amount_paid, :payment_mode, :return_trip)
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