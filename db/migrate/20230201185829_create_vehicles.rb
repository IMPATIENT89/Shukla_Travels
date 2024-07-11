class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :vehicle_no, null: false
      t.string :registration_no, null: false
      t.integer :no_of_seats
      t.integer :host_id
      t.string :car_name, null: false
      t.timestamps
    end
  end
end
