class CreateProfitGroups < ActiveRecord::Migration
  def self.up
    create_table :businesses do |t|
      t.string	 	:name, null: false, index: true
      t.string	 	:state
      t.string    :category, null: false, index: true
      t.jsonb       :profile, null: false, default: {}
      t.jsonb       :preferences, default: {}
      t.datetime    :deleted_at, index: true
      t.string :slug, null: false, index: true, unique: true

      t.timestamps null: false
    end
    add_index  :businesses, :profile, using: :gin    
  end

  def self.down
    drop_table :businesses
  end    
end