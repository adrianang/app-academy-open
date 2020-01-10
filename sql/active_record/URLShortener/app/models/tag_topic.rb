class TagTopic < ApplicationRecord
  validates :topic, presence: true, uniqueness: true

  has_many :taggings,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: :Tagging

  has_many :short_urls, through: :taggings, source: :shortened_url

  def popular_links
    links = []
    self.short_urls.each { |short_url| links << [short_url, short_url.num_clicks] }
    links.sort { |a, b| a[1] <=> b[1] }.reverse.slice(0, 5)
  end
end