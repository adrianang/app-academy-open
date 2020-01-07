class Visit < ApplicationRecord
  validates :short_url_id, presence: true
  validates :user_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!(short_url_id: shortened_url.id, user_id: user.id)
  end

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :ShortenedUrl
end