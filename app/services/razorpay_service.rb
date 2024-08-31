class RazorpayService
  attr_reader :user
  def initialize(user, amount, booking)
    @user = user
    @amount = amount
    @booking = booking
  end

  def find_or_create_customer
    if @user.razorpay_customer_id.present?
      customerId = @user.razorpay_customer_id
      response = Razorpay::Customer.fetch(customerId)
    else
      para_attr = {
        "name": @user.customer_full_name,
        "contact": @user.phone,
        "email": @user.email,
      }
  
      response = Razorpay::Customer.create(para_attr)
      @user.update!(razorpay_customer_id: response.attributes['id'])
    end 
  end

  def find_order_status
    if @booking.order_id.present?
      orderId = @booking.order_id
      response = Razorpay::Order.fetch(orderId)
      puts response.attributes['status']
      return response.attributes['status']
    end     
  end

  def create_order
    current_time = Time.now
    time_in_30_minutes = current_time + 30*60 # 30 minutes in seconds
    unix_timestamp = time_in_30_minutes.to_i

    para_attr = {
      "amount": @amount * 100,
      "currency": "INR",
      "method": "upi",
      "customer_id": @user.razorpay_customer_id,
      "receipt": "Receipt No. 1",
      "notes": {
        "notes_key_1": "Booking Payment for the trip from #{@booking.booking_from} to #{@booking.booking_to} on #{@booking.booking_date}",
      },
      "token": {
        "max_amount": 1000000,
        "expire_at": unix_timestamp,
      }
    }
    response = Razorpay::Order.create(para_attr)

    return response.attributes['id']
  end
end
