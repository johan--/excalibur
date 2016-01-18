class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.string  :mentioner_type, null: false
      t.integer :mentioner_id, null: false
      t.string  :mentionable_type, null: false
      t.integer :mentionable_id, null: false
      t.datetime :created_at
    end

    add_index :mentions, ["mentioner_id", "mentioner_type"],   :name => "fk_mentions"
    add_index :mentions, ["mentionable_id", "mentionable_type"], :name => "fk_mentionables"
  end
end
