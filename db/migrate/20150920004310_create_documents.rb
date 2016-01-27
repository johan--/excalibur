class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string		  :ticker, null: false
      t.string      :type
      t.string		  :category
      t.string		  :slug, null: false
      t.jsonb		    :details
      t.references	:owner, polymorphic: true, null: false
      t.datetime    :deleted_at, index: true
      
      t.timestamps null: false
    end
    add_index :documents, :slug, unique: true
    add_index :documents, :details, using: :gin
  end

  def self.down
    drop_table :documents
  end  
end
