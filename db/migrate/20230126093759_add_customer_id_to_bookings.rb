class AddCustomerIdToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :customer_id, :int
  end
end
