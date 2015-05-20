class CreateDailyStatistics < ActiveRecord::Migration
  def change
    create_table :daily_statistics do |t|
      t.string   :date
      t.integer  :statistic
      t.integer  :sum
      t.belongs_to :movie, index: true

      t.timestamps null: false
    end
  end
end
