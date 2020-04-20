class AddQuestionIdToAnswerChoices < ActiveRecord::Migration[6.0]
  def change
    add_column :answer_choices, :question_id, :integer, null: false
  end
end
