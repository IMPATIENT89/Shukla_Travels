class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :phone
      t.string :customer_full_name
      t.string :stripe_customer_id
      t.timestamps
    end
  end
end
