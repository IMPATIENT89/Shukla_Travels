class AddRazorpayDetailsToCustomersAndBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :razorpay_customer_id, :string
    add_column :bookings, :order_id, :string
    add_column :bookings, :payment_mode, :string
    add_column :bookings, :payment_status, :string, default: 'pending'
  end
end
