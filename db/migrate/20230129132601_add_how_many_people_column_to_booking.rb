class AddHowManyPeopleColumnToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :how_many_people, :int
  end
end
