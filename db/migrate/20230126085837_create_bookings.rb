class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :booking_from, null: false
      t.string :booking_to, null: false
      t.integer :customer_id
      t.datetime :booking_date
      t.integer :how_many_people
      t.string :choose_car
      t.string :stripe_transaction_id
      t.float :amount_paid
      t.integer :vehicle_id
      t.timestamps
    end
  end
end
