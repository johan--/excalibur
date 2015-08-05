class CreateBlogResources < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content_md, null: false
      t.text :content_html, null: false
      t.boolean :draft, default: false
      t.integer :user_id, null: false

      # FriendlyId
      t.string :slug

      # Image
      t.string :header

      # Tag
      t.jsonb :keywords, null: false, default: {}
      t.timestamps null: false
    end
    add_index :posts, :user_id
    add_index :posts, :slug, unique: true
    add_index :posts, :keywords, using: :gin

    create_table :subscribers do |t|
      t.string :email, null: false, index: true
      t.string :name
      t.string :category, null: false, index: true

      t.timestamps null: false
    end    
  end
end
