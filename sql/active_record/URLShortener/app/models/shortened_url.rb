require 'SecureRandom'
require_relative 'user'

class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  def self.random_code
    random_code = SecureRandom.urlsafe_base64
    ShortenedUrl.exists?(random_code) ? ShortenedUrl.random_code : random_code
  end

  def self.make_shortened_url(user, long_url)
    ShortenedUrl.create!(short_url: self.random_code, long_url: long_url, user_id: user.id)
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
end