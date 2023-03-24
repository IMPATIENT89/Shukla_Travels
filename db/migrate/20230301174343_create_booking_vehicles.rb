class CreateBookingVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_vehicles do |t|
      t.integer :"booking_id"
      t.integer :"vehicle_id"
      t.timestamps
    end
  end
end
