class Cart < ActiveRecord::Base
  #-----------------------Associations--------------------------
  has_many :cart_items, dependent: :destroy
  belongs_to :user

  #-----------------------Callbacks-----------------------------
  before_destroy { user.reserved_tickets.destroy_all_reservations }

  #-----------------------Instance methods----------------------
  def quantity
    cart_items.sum(:quantity)
  end

  def total_price
    cart_items.joins(:ticket).sum('quantity * price')
  end
end
