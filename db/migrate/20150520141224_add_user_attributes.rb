class AddUserAttributes < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :deleted_at, :datetime, index: true
	add_column :users, :avatar, :string
	add_column :users, :profile, :jsonb, default: {}
	add_column :users, :preferences, :jsonb, null: false, default: {}
	add_index  :users, :profile, using: :gin
  end
end
