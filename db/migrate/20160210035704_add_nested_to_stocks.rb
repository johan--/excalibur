class AddNestedToStocks < ActiveRecord::Migration
  def self.up
    add_column :stocks, :parent_id, :integer, null: true, index: true
    # Uncomment this line if your project already has :parent_id
    # Category.where(parent_id: 0).update_all(parent_id: nil) 
    add_column :stocks, :lft,       :integer, index: true
    add_column :stocks, :rgt,       :integer, index: true

    # optional fields
    add_column :stocks, :depth,          :integer, default: 0
    add_column :stocks, :children_count, :integer, default: 0

    # This is necessary to update :lft and :rgt columns, use it to update
    # Stock.rebuild!
  end

  def self.down
    remove_column :stocks, :parent_id
    remove_column :stocks, :lft
    remove_column :stocks, :rgt

    # optional fields
    remove_column :stocks, :depth
    remove_column :stocks, :children_count
  end
end
