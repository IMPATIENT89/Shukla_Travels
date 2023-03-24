class AddVehicleNoToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :vehicle_no, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
