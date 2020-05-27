class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper
  CAT_COLORS = %w(black brown orange white)

  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: CAT_COLORS }
  validates :sex, length: { maximum: 1 }, inclusion: { in: %w(M F) }

  def age
    age_from_today = Date.today - birth_date
    time_ago_in_words(age_from_today.days.ago)
  end

  has_many :rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy
end