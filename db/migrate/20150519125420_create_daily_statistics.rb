class CreateDailyStatistics < ActiveRecord::Migration
  def change
    create_table :daily_statistics do |t|
      t.date   :date
      t.decimal  :sum
      t.belongs_to :movie, index: true

      t.timestamps null: false
    end
    add_index :daily_statistics, [:movie_id, :date], unique: true
  end
end
