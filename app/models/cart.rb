class Cart < ActiveRecord::Base
  #-----------------------Associations--------------------------
  has_many :cart_items, dependent: :destroy
  belongs_to :user
end
