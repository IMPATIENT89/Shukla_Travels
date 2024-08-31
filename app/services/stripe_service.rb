require 'stripe'

class StripeService
  def initialize()
      Stripe.api_key = "sk_test_51Mlnn9SGp43kXJ7FPQ6jtZeLAMMdgmfGkGJCOywJDHaoU42MFFWBxIc21ctwQmHomSR5unALG4AVHl3RwnvGIGHv00D9vxkh5T"
  end
  
  def create_payment_method(params)
    payment_method = Stripe::PaymentMethod.create({
      type: 'card',
      card: {
        number: params[:card_number].to_s,
        exp_month: params[:exp_month],
        exp_year: params[:exp_year],
        cvc: params[:cvv]
      }
    })
    payment_method
  end
  def find_or_create_customer(customer, payment_method_id)
    if customer.stripe_customer_id.present?
      stripe_customer = Stripe::Customer.retrieve(customer.stripe_customer_id)
    else
      stripe_customer = Stripe::Customer.create({
        name: customer.customer_full_name,
        email: customer.email,
        phone: customer.phone,
        payment_method: payment_method_id
      })
      customer.update(stripe_customer_id: stripe_customer.id)
    end   
    stripe_customer
  end
  def create_stripe_payment_intent(amount_to_be_paid, stripe_customer_id , payment_method_id, booking)
    Stripe::PaymentIntent.create({
      amount: amount_to_be_paid * 100,
      currency: 'usd',
      payment_method: payment_method_id,
      customer: stripe_customer_id,        
      description: "Amount #{amount_to_be_paid} charged for the trip from #{booking.booking_from} to #{booking.booking_to} on #{booking.booking_date}",
      confirm: true,
      automatic_payment_methods: {
        enabled: true,
        allow_redirects: 'never'
      }
    })      
  end
end