class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.date   :release_date
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
