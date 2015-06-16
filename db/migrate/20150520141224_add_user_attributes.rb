class AddUserAttributes < ActiveRecord::Migration
  def change
    add_column :users, :full_name, :string, null: false
    add_column :users, :deleted_at, :datetime, index: true
	add_column :users, :category, :integer, index: true, null: false, default: 1
  end
end
