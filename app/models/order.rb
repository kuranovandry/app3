class Order < ActiveRecord::Base
  #-----------------------Associations--------------------------
  belongs_to :user
  has_many :order_items, dependent: :destroy
  #-----------------------Validations----------------------------
  validates :user, presence: true
end
