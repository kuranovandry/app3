class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :creditor, index: true
      t.belongs_to :debitor, index: true
      t.decimal :amount, precision: 12, scale: 2
      t.belongs_to :user, index: true
      t.string :memo
      t.timestamps null: false
    end
  end
end
