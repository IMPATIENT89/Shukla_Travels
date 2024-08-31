ActiveAdmin.register Booking do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :booking_from, :booking_to, :customer_id, :booking_date, :how_many_people, :choose_car, :stripe_transaction_id, :amount_paid, :vehicle_id, :order_id, :payment_mode, :payment_status
  #
  # or
  #
  # permit_params do
  #   permitted = [:booking_from, :booking_to, :customer_id, :booking_date, :how_many_people, :choose_car, :stripe_transaction_id, :amount_paid, :vehicle_id, :order_id, :payment_mode, :payment_status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  
end
