class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: %w(APPROVED DENIED PENDING) }
  validate :end_date_cannot_be_before_start_date

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat

  def overlapping_requests
    CatRentalRequest.where.not('start_date > ? OR end_date < ?', end_date, start_date)
                    .where.not('id = ?', id)
  end

  def overlapping_approved_requests
    self.overlapping_requests.where('status = ?', "APPROVED")
  end

  def does_not_overlap_approved_request
    self.overlapping_approved_requests.exists? ? false : true
  end

  def end_date_cannot_be_before_start_date
    if start_date > end_date
      errors.add(:end_date, "can't be before the start date")
    end
  end
end