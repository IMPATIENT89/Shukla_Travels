class AddFullNameColumnToCustomersAndHostesTable < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :customer_full_name, :string
    add_column :hostes, :host_full_name, :string
  end
end
