class CreateMonthlyStatistics < ActiveRecord::Migration

  def change
    create_table :monthly_statistics do |t|
      t.date   :date
      t.decimal  :sum
      t.belongs_to :movie, index: true

      t.timestamps null: false
    end
    add_index :monthly_statistics, [:movie_id, :date]
  end

end
