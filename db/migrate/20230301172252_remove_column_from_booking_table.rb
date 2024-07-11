class RemoveColumnFromBookingTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :vehicle_id
    remove_column :bookings, :vehicle_no
  end
end
