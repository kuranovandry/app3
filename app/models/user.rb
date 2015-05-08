class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #-----------Validations------------
  validates :first_name, :last_name, :date_of_birth, presence: true

  #-------------Associations-------------
  has_many :projects, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :movies, dependent: :destroy
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address

  def full_name
    "#{first_name} #{last_name}"
  end
end
