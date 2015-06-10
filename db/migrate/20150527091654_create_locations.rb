class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :country, lenght: 40
      t.string :city, lenght: 40
      t.string :address, lenght: 40
      t.integer :zip_code, lenght: 15
      t.float :longitude
      t.float :latitude
      t.belongs_to :movie, index: true

      t.timestamps null: false
    end
  end
end
