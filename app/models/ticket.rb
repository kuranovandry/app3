class Ticket < ActiveRecord::Base
  #-----------------------Associations--------------------------
  belongs_to :movie
  belongs_to :reserved_by, foreign_key: :reserved_by_id, class_name: 'User'
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  delegate :name, to: :movie, allow_nil: true
  #----------------------------Scopes--------------------------------------
  scope :available, -> { where(bought: false, reserved_by_id: nil) }

  #-----------------------Validations---------------------------
  validates :movie, :price, :place_number, presence: true
  validates :price, numericality: true
  validates :place_number, numericality: true
  validates :place_number, uniqueness: true
end
