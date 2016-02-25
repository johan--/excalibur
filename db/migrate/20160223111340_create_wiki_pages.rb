class CreateWikiPages < ActiveRecord::Migration
  def self.up
    create_table :wiki_pages do |t|
      t.integer :creator_id
      t.integer :updator_id

      t.string :path
      t.string :title, null: false
      t.string :slug, index: true, unique: true
      t.jsonb  :details

      # t.text :content, limit: 4_294_967_295
      t.text :content_md, limit: 1_000_000_000
      t.text :content, limit: 1_000_000_000
      t.timestamps null: false
    end

    add_index :wiki_pages, :creator_id
    add_index :wiki_pages, :path, unique: true

    create_table :wiki_page_versions do |t|
      t.integer :page_id, null: false # Reference to page
      t.integer :updator_id # Reference to user, updated page

      t.integer :number # Version number

      t.string :comment

      t.string :path
      t.string :title

      # t.text :content, limit: 4_294_967_295
      t.text :content, limit: 1_000_000_000
      t.timestamp :updated_at, null: false
    end

    add_index :wiki_page_versions, :page_id
    add_index :wiki_page_versions, :updator_id
  end

  def self.down
    drop_table :wiki_page_versions
    drop_table :wiki_pages
  end
end
