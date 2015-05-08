class CategoriesMovie < ActiveRecord::Base

  belongs_to :movie, dependent: :destroy
  belongs_to :category, dependent: :destroy

end
