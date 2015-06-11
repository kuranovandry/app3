class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :postal_code, limit: 20
      t.string :address
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
