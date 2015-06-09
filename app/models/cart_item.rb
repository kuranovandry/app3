class CartItem < ActiveRecord::Base
  #-----------------------Associations--------------------------
  belongs_to :cart
  belongs_to :ticket
  #-----------------------Validations---------------------------
  validates_presence_of :cart, :ticket
  validates_numericality_of :quantity, greater_than_or_equal_to: 1, only_integer: true
end
