class Upload < ActiveRecord::Base
  belongs_to :movie
  has_attached_file :file, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :file, content_type: %r{/\Aimage\/.*\Z/}

  paginates_per 5
end
