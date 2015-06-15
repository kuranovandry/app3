class Project < ActiveRecord::Base
  #-----------Validations------------
  validates :name, :description, :start_date, :end_date, presence: true
  paginates_per 5
  #-------------Associations-------------
  belongs_to :user
end
