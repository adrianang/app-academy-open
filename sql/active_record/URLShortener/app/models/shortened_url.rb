require 'SecureRandom'
require_relative 'user'

class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true
  validate :no_spamming
  validate :nonpremium_max

  def self.random_code
    random_code = SecureRandom.urlsafe_base64
    ShortenedUrl.exists?(short_url: random_code) ? ShortenedUrl.random_code : random_code
  end

  def self.make_shortened_url(user, long_url)
    ShortenedUrl.create!(short_url: self.random_code, long_url: long_url, user_id: user.id)
  end

  def self.prune(time)
    ShortenedUrl.all.each do |short_url|
      if short_url.num_clicks == 0
        short_url.destroy unless short_url.submitter.premium
      elsif (Time.now - short_url.visits.last.created_at) > time.minutes
        short_url.destroy unless short_url.submitter.premium
      end
    end
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

  def no_spamming
    if self.submitter.submitted_urls[-5]
      if (Time.now - self.submitter.submitted_urls[-5].created_at) < 60
        errors[:base] << "Cannot submit more than 5 URLs in under a minute"
      end
    end
  end

  def nonpremium_max
    if !self.submitter.premium
      if self.submitter.submitted_urls.count >= 5
        errors[:base] << "Nonpremium users cannot submit more than 5 URLs"
      end
    end
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits, dependent: :destroy,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Visit

  has_many :visitors, -> { distinct }, through: :visits, source: :user

  has_many :taggings, dependent: :destroy,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Tagging

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic
end