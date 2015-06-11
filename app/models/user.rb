class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  after_create -> { build_address }
  paginates_per 5

  FILTER = [['All', ''], ['With projects', 'with_project'], ['Without projects', 'without_project']]

  #-----------Validations------------
  validates :first_name, :last_name, presence: true

  #-------------Associations-------------
  has_many :projects, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :movies, dependent: :destroy
  has_one :address, dependent: :destroy

  has_many :debit_transactions, foreign_key: :debitor_id, class_name: 'Transaction', dependent: :destroy
  has_many :credit_transactions, foreign_key: :creditor_id, class_name: 'Transaction', dependent: :destroy
  has_many :admin_transactions, foreign_key: :user_id, class_name: 'Transaction', dependent: :destroy
  accepts_nested_attributes_for :address

  scope :with_project, -> { joins(:projects).distinct }
  scope :without_project, lambda {
                          joins('LEFT JOIN projects on (users.id = projects.user_id)')
                            .where('projects.user_id IS NULL') }

  #-----------Instance methods------------
  def full_name
    "#{first_name} #{last_name}"
  end

  def balance
    debit_transactions.sum(:amount) - credit_transactions.sum(:amount)
  end

  def update_balance(value)
    update_attribute(:current_amount, value)
  end

  def payable?
    balance > 0
  end

  def transfer_money(obtainer_id, amount)
    credit_transactions.create(debitor_id: obtainer_id, amount: amount)
  end

  def add_money(debitor_id, amount, memo)
    admin_transactions.create(debitor_id: debitor_id, amount: amount, memo: memo)
  end
  #-----------Class methods------------
  def self.filter(method)
    method.present? && respond_to?(:method) ? send(method) : all
  end

  def self.connections(auth, _signed_in_resource = nil)
    User.where(provider: auth.provider, uid: auth.uid).first ||
      User.where(email: auth.info.email).first ||
      User.create(first_name: auth.info.first_name, last_name: auth.info.last_name, provider: auth.provider,
                    uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20])
  end

  def self.to_csv_generator
    user_fields = %w(id email first_name last_name)
    CSV.generate do |csv|
      csv << user_fields
      all.each do |user|
        csv << user.attributes.values_at(*user_fields)
      end
    end
  end
end
