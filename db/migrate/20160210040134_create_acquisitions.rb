class CreateAcquisitions < ActiveRecord::Migration
  def change
    create_table :acquisitions do |t|
      t.references :benefactor, polymorphic: true, index: true
      t.references :bid, null: false, index: true
      t.references :acquireable, polymorphic: true, index: true
	  t.string     :slug, unique: true
	  t.jsonb      :details, default: {}
      t.timestamps null: false
    end
    add_foreign_key :acquisitions, :bids
    add_index 		:acquisitions, :details, using: :gin
  end
end
