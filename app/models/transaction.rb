class Transaction < ActiveRecord::Base
  #---------------------Associations----------------------
  belongs_to :creditor, foreign_key: :creditor_id, class_name: 'User'
  belongs_to :debitor, foreign_key: :debitor_id, class_name: 'User'
  belongs_to :user
  has_one :order_item
  #---------------------Callbacks-------------------------
  after_create { creditor.update_balance(creditor.balance) if creditor}
  after_create { debitor.update_balance(debitor.balance) }
  #---------------------Validations-----------------------
  validates_presence_of :debitor_id, :amount
  validates_numericality_of :amount, greater_than: 0
  validates_presence_of :user_id, :memo, if: 'creditor_id.nil?'
  validate :can_afford?, :not_equal?, unless: 'creditor_id.nil?'

  #---------------------Instance methods------------------
  private

  def can_afford?
    condition = creditor.balance - amount >= 0
    errors.add(:amount, "You don't have enough money.") unless condition
  end

  def not_equal?
    errors.add(:base, 'Debitor and creditor are the same.') if creditor.id == debitor.id
  end
end
