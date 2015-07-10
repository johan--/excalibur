class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :tender, index: true
      t.references :bidder, polymorphic: true
      t.string :barcode
      t.string :state
      t.decimal :total
      t.decimal :maturity

      t.timestamps null: false
    end
    add_foreign_key :bids, :tenders
  end
end
