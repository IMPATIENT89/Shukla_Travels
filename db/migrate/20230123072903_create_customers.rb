class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :phone
      t.timestamps
    end
  end
end
