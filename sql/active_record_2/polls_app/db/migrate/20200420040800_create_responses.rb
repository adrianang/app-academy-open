class CreateResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.integer :answer_choice_id, null: false
      t.integer :user_id, null: false
      
      t.timestamps
    end
  end
end
