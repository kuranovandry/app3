class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.belongs_to :user, index: true
      t.belongs_to :movies, index: true

      t.timestamps null: false
    end
  end
end
