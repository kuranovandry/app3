class Order < ActiveRecord::Base
  #-----------------------Associations--------------------------
  belongs_to :user
  has_many :order_items, dependent: :destroy
  #-----------------------Validations----------------------------
  validates_presence_of :user
end
