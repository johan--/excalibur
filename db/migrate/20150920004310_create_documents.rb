class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string		:name
      t.string		:category
      t.string		:location
      t.jsonb		:details
      t.references	:owner, polymorphic: true, null: false
      t.timestamps null: false
    end
  end
end
