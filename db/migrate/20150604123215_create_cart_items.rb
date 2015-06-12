class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.belongs_to :ticket, index: true
      t.integer :quantity
      t.belongs_to :cart, index: true
      t.timestamps null: false
    end
  end
end
