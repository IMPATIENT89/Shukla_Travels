class AddVehicleIdToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :vehicle_id, :int
  end
end
