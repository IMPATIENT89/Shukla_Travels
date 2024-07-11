class CreateHostes < ActiveRecord::Migration[7.0]
  def change
    create_table :hostes do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :phone, null: false
      t.integer :no_of_cars
      t.string :car_no
      t.timestamps
    end
  end
end
