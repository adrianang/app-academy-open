class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.integer :topic_id, null: false
      t.integer :short_url_id, null: false
    end

    add_index :taggings, :topic_id
    add_index :taggings, :short_url_id
  end
end
