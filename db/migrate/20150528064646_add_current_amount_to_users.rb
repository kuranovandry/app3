class AddCurrentAmountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_amount, :decimal, precision: 12, scale: 2
  end
end
