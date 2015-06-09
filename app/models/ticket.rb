class Ticket < ActiveRecord::Base
  #-----------------------Associations--------------------------
  belongs_to :movie
  delegate :name, to: :movie, allow_nil: true
  belongs_to :owner, foreign_key: :owner_id, class_name: 'User'
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  #

  #-----------------------Validations---------------------------
  validates_presence_of :movie, :owner, :price, :place_number
  validates_numericality_of :price, greater_than: 0
  validates_numericality_of :place_number, greater_than: 0, only_integer: true
  validates_uniqueness_of :place_number, scope: :movie_id
  #-----------------------Class Methods-------------------------
  def self.create_tickets_for_movie(movie, price = 50, amount = 60)
    amount.times{|i| movie.tickets.create(owner: movie.user, price: price, place_number: i + 1) }
  end

  def self.available_tickets(movie_id)
    joins('LEFT JOIN order_items on (tickets.id = order_items.ticket_id)').where('order_items.ticket_id IS NULL')
        .where(movie_id: movie_id)
  end
end
