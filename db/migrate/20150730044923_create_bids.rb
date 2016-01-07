class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.references :bidder, polymorphic: true, null: false
      t.references :tender, null: false
      t.string 	   :state, null: false
      t.monetize   :contribution, null: false
      t.jsonb :properties, default: {}
      t.jsonb :details, default: {}
      t.string :slug, null: false, index: true, unique: true
      t.datetime    :deleted_at, index: true

      t.timestamps null: false
    end
    change_column :bids, :contribution_sens, :bigint, default: 0, null: false
    add_index :bids, [:bidder_type, :bidder_id]
    add_index :bids, :tender_id
    add_index :bids, :properties, using: :gin    
  end

  def self.down
    drop_table :bids
  end
end