class RemoveColumnFromTables < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookings, :no_of_people
    remove_column :bookings, :number_of_people
    remove_column :bookings, :vehicle_type
    remove_column :hostes, :car_no
  end
end
