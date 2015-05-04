class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #-----------Validations------------
  validates :first_name, :last_name, :date_of_birth,  presence: true

  #-------------Associations-------------
  has_many :projects
end
