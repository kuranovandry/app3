class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create -> { build_address }

  #-----------Validations------------
  validates :first_name, :last_name, :date_of_birth, presence: true

  #-------------Associations-------------
  has_many :projects
  has_one :address
  accepts_nested_attributes_for :address

end
