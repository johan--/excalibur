class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :bidder, polymorphic: true, null: false
      t.references :tender, null: false
      t.string 	   :state, null: false
      t.monetize   :contribution, null: false
      t.jsonb :properties, null: false, default: {}
      t.jsonb :details, default: {}

      t.timestamps null: false
    end
    add_index :bids, [:bidder_type, :bidder_id]
    add_index :bids, :tender_id
    add_index :bids, :state
    add_index :bids, :properties, using: :gin    
  end
end
