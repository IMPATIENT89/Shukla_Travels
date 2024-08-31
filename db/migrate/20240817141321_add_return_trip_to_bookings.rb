class AddReturnTripToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :return_trip, :boolean, default: false
  end
end
