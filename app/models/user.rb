class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  after_create -> { build_address }
  paginates_per 5

  #-----------Validations------------
  validates :first_name, :last_name, presence: true

  #-------------Associations-------------
  has_many :projects, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :movies, dependent: :destroy
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address

  #-----------Instance methods------------
  def full_name
    "#{first_name} #{last_name}"
  end

  #-----------Class methods------------
  def self.connections(auth, signed_in_resource=nil)
    User.where(provider: auth.provider, uid: auth.uid).first ||
    User.where(email: auth.info.email).first ||
    User.create(first_name: auth.info.first_name, last_name: auth.info.last_name, provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0,20])
  end
end
