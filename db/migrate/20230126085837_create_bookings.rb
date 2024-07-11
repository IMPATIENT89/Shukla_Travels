class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.integer :no_of_people
      t.string :booking_from, null: false
      t.string :booking_to, null: false
      t.datetime :booking_date
      t.timestamps
    end
  end
end
