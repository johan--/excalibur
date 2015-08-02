class AddSlugsToMultipleTable < ActiveRecord::Migration
  def change
	add_column :users, :slug, :string, null: false, index: true, unique: true
  	add_column :businesses, :slug, :string, null: false, index: true, unique: true
  	add_column :tenders, 	:slug, :string, null: false, index: true, unique: true
  	add_column :bids, 		:slug, :string, null: false, index: true, unique: true
  end
end
