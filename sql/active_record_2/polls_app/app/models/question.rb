class Question < ApplicationRecord
  validates :text, presence: true
  validates :poll_id, presence: true

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :answer_choices, dependent: :destroy,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  has_many :responses, through: :answer_choices, source: :responses

  def results
    self.answer_choices.select(:text)
        .group(:text)
        .left_outer_joins(:responses)
        .count("responses.id")
  end

#   The following methods are here to compare two ways to get poll results, for learning purposes only.
#   def n_plus_one_results
#     results = self.answer_choices
    
#     results_counts = {}
#     results.each do |answer_choice|
#       results_counts[answer_choice.text] = answer_choice.responses.length
#     end

#     results_counts
#   end

#   def includes_results
#     results = self.answer_choices.includes(:responses)

#     results_counts = {}
#     results.each do |answer_choice|
#       results_counts[answer_choice.text] = answer_choice.responses.length
#     end

#     results_counts
#   end
end