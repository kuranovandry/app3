class Movie < ActiveRecord::Base
  #------------------------------Associations---------------------------------
  belongs_to :user

  has_many :categories, through: :categories_movies

  has_many :categories_movies, dependent: :destroy
  has_many :uploads, dependent: :destroy
  has_many :daily_statistics, dependent: :destroy
  has_many :monthly_statistics, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :tickets, dependent: :destroy

  accepts_nested_attributes_for :locations

  #------------------------------Callbacks---------------------------------
  attr_writer :skip_tickets
  after_create { create_tickets unless @skip_tickets }

  #------------------------------Paperclip---------------------------------
  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: 'missing.jpg'

  #------------------------------Validations-------------------------------
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  validates :description, :name, presence: true
  validates :duration, numericality: { greater_than_or_equal_to: 40, less_than_or_equal_to: 240 }

  #------------------------------Kaminari----------------------------------
  paginates_per 10

  #----------------------------Instance methods----------------------------
  def create_tickets(price = 50, amount = 60)
    tickets.create((1..amount).inject([]) { |a, e| a << { place_number: e } }) do |t|
      t.price = price
    end
  end

  #----------------------------Class methods-------------------------------
  def self.to_csv_generator
    movies_fields = %w(name description)
    CSV.generate do |csv|
      csv << movies_fields
      find_each do |movie|
        csv << movie.attributes.values_at(*movies_fields)
      end
    end
  end
end
