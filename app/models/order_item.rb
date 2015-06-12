class OrderItem < ActiveRecord::Base
  #-----------------------Associations--------------------------
  belongs_to :order
  belongs_to :ticket
  belongs_to :order_transaction, foreign_key: :transaction_id, class_name: 'Transaction'

  delegate :name, :place_number, to: :ticket
  #-----------------------Validations---------------------------
  validates_presence_of :order, :ticket, :price, :transaction_id
  validates_numericality_of :price, greater_than: 0
end
