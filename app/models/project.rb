class Project < ActiveRecord::Base
  #-----------Validations------------
  validates_presence_of :name, :description, :start_date, :end_date
  paginates_per 5
  #-------------Associations-------------
  belongs_to :user
end
