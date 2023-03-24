class AddVehicleTypeColumnsToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :vehicle_type, :string
  end
end
