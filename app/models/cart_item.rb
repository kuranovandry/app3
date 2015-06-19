class CartItem < ActiveRecord::Base
  #-----------------------Associations--------------------------
  belongs_to :cart
  belongs_to :ticket

  delegate :name, :price, to: :ticket
  #-----------------------Validations---------------------------
  validates :cart, :ticket, presence: true
  validates :quantity, numericality: true

  #-----------------------Callbacks-----------------------------
  before_destroy { ticket.destroy_reservation }

  #-------------------------Instance methods--------------------
  def total
    quantity * ticket.price
  end
end
