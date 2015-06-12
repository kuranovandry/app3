class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.decimal :price, precision: 8, scale: 2
      t.belongs_to :movie, index: true
      t.integer :place_number
      t.boolean :bought, default: false
      t.belongs_to :reserved_by
      t.timestamps null: false
    end
  end
end
