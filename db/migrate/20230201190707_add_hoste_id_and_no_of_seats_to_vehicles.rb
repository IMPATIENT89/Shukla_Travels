class AddHosteIdAndNoOfSeatsToVehicles < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :hoste_id, :int
    add_column :vehicles, :no_of_seats, :int
  end
end
