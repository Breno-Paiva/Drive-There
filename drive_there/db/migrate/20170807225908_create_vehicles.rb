class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.string :location, null: false
      t.string :car_type, null: false
      t.string :make, null: false
      t.string :model, null: false
      t.integer :year, null: false
      t.integer :rental_cost, null: false
      t.timestamps
    end
  end
end
