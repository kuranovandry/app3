class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.belongs_to :order, index: true
      t.integer :price
      t.belongs_to :ticket, index: true
      t.belongs_to :transaction, index: true
      t.timestamps null: false
    end
  end
end
