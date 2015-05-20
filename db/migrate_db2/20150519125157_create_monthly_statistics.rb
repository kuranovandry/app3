class CreateMonthlyStatistics < ActiveRecord::Migration

  def change
    create_table :monthly_statistics do |t|
      t.string   :date
      t.integer  :statistic
      t.string   :movie_name

      t.timestamps null: false
    end
  end

end
