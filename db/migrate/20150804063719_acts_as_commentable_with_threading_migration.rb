class ActsAsCommentableWithThreadingMigration < ActiveRecord::Migration
  def self.up
    create_table :comments, :force => true do |t|
      t.integer :commentable_id, null: false
      t.string :commentable_type, null: false
      t.string :title
      t.text :body_html
      t.text :body_md
      t.string :subject
      t.integer :user_id, :null => false
      t.integer :parent_id, :lft, :rgt
      t.jsonb      :details
      t.datetime   :deleted_at, index: true

      t.timestamps null: false
    end

    add_index :comments, :details, using: :gin
    add_index :comments, :user_id
    add_index :comments, [:commentable_id, :commentable_type]
  end

  def self.down
    drop_table :comments
  end
end
