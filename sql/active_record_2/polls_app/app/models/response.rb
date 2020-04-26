class Response < ApplicationRecord
  validates :answer_choice_id, presence: true
  validates :user_id, presence: true
  validate :not_duplicate_response
  validate :not_poll_author_response

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question, through: :answer_choice, source: :question

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    self.sibling_responses.exists?(user_id: self.respondent.id)
  end

  def not_duplicate_response
    if self.respondent_already_answered?
      errors[:respondent] << 'has already answered'
    end
  end

  def author_wrote_poll?
    self.question.poll.user_id == self.user_id
  end

  def not_poll_author_response
    if self.author_wrote_poll?
      errors[:respondent] << 'cannot answer this poll'
    end
  end
end