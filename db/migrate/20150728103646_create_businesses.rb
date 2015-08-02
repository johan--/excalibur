class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string	 	  :name, null: false
      t.jsonb       :profile, null: false, default: {}
      t.datetime    :deleted_at, index: true
      
      t.timestamps null: false
    end
    add_index  :businesses, :profile, using: :gin
  end
end
