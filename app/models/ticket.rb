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
  validates_presence_of :movie, :price, :place_number
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :place_number, greater_than: 0, only_integer: true
  validates_uniqueness_of :place_number, scope: :movie_id
end
