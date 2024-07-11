class AddAmountAndStripeTransactionIdToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :amount_paid, :float
    add_column :bookings, :stripe_transaction_id, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
