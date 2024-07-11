class CreateHosts < ActiveRecord::Migration[7.0]
  def change
    create_table :hosts do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :phone, null: false
      t.integer :no_of_cars
      t.string :host_full_name
      t.timestamps
    end
  end
end
