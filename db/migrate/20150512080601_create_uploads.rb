class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.belongs_to :movie, index: true
      t.timestamps null: false
    end
  end
end
