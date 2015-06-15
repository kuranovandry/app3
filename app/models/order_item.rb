class OrderItem < ActiveRecord::Base
  #-----------------------Associations--------------------------
  belongs_to :order
  belongs_to :ticket
  belongs_to :order_transaction, foreign_key: :transaction_id, class_name: 'Transaction'

  delegate :name, :place_number, to: :ticket
  #-----------------------Validations---------------------------
  validates :order, :ticket, :price, :transaction_id, presence: true
  validates :price, numericality: true
end
