class Ticket < ActiveRecord::Base
  #-----------------------Associations--------------------------
  belongs_to :movie
  belongs_to :reserved_by, foreign_key: :reserved_by_id, class_name: 'User'
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  delegate :name, to: :movie, allow_nil: true
  #----------------------------Scopes--------------------------------------
  scope :available, -> { where(bought: false, reserved_by_id: nil) }
  scope :specific_session, -> (time, date) { where(session_time: time, session_date: date) }

  #-----------------------Validations---------------------------
  validates :movie, :price, :place_number, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :place_number,
            numericality: { greater_than: 0, only_integer: true },
            uniqueness: { scope: %i(movie_id session_date) }

  #-----------------------Instance methods----------------------
  def destroy_reservation
    update_attribute(:reserved_by_id, nil)
  end

  #-----------------------Class methods--------------------------
  def self.destroy_all_reservations
    update_all(reserved_by_id: nil)
  end
end
