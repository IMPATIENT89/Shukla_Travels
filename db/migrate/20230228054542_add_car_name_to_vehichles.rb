class AddCarNameToVehichles < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :car_name, :string
  end
end
