class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string 		:category
      t.string		:state
      t.monetize  :amount, null: false
      t.string    :slug, index: true, unique: true, null: false
      t.jsonb		:details
      t.references  :tender, null: false
      t.timestamps null: false
    end
    add_index :deals, :tender_id
    add_index :deals, :category
    add_index :deals, :details, using: :gin
  end
end
