class AddFilesColumnsToUploads < ActiveRecord::Migration
  def up
    add_attachment :uploads, :file
  end

  def down
    remove_attachment :uploads, :file
  end
end
