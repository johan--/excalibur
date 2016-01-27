class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.references :bidder, polymorphic: true, null: false
      t.references :tender, null: false, index: true
      t.string     :ticker
      t.integer    :volume, null: false
      t.monetize   :price, null: false
      t.jsonb :details, default: {}
      t.string :slug, null: false, index: true, unique: true
      t.datetime    :deleted_at, index: true

      t.timestamps null: false
    end
    change_column :bids, :price_sens, :bigint, null: false
    add_index :bids, [:bidder_type, :bidder_id]
    add_index :bids, :details, using: :gin
  end

  def self.down
    drop_table :bids
  end
end