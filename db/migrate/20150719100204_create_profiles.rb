class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :profileable, polymorphic: true, null: false
      t.string :about
      t.json :details, default: {}
	    t.datetime   :deleted_at, index: true
	  
      t.timestamps null: false
    end
    add_index :profiles, [:profileable_id, :profileable_type]
  end
end
