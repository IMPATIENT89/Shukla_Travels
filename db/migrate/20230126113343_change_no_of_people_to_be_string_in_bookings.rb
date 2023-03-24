class ChangeNoOfPeopleToBeStringInBookings < ActiveRecord::Migration[7.0]
  def change
    change_column :bookings, :no_of_people, :string
  end
end
