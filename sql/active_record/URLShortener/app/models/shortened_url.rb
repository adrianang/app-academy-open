require 'SecureRandom'
require_relative 'user'

class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  def self.random_code
    random_code = SecureRandom.urlsafe_base64
    ShortenedUrl.exists?(short_url: random_code) ? ShortenedUrl.random_code : random_code
  end

  def self.make_shortened_url(user, long_url)
    ShortenedUrl.create!(short_url: self.random_code, long_url: long_url, user_id: user.id)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visits.select(:user_id).distinct.where({ created_at: (Time.now - 60.minutes)..(Time.now) }).count
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Visit

  has_many :visitors, -> { distinct }, through: :visits, source: :user
end