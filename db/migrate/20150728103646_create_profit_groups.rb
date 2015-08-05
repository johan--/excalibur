class CreateProfitGroups < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string	 	:name, null: false, index: true
      t.string	 	:state, null: false
      t.jsonb       :profile, null: false, default: {}
      t.jsonb       :preferences, default: {}
      t.datetime    :deleted_at, index: true
      
      t.timestamps null: false
    end
    add_index  :businesses, :profile, using: :gin

    create_table :firms do |t|
      t.string	 	:name, null: false, index: true
      t.string	 	:state, null: false
      t.jsonb       :profile, null: false, default: {}
      t.jsonb       :preferences, default: {}
      t.datetime    :deleted_at, index: true
      
      t.timestamps null: false
    end    
  end
end