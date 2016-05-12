class AddSocialCounterToUserTables < ActiveRecord::Migration
  def self.up
  	add_column :users, :likers_count, :integer, :default => 0
  	add_column :users, :followees_count, :integer, :default => 0
  	add_column :users, :followers_count, :integer, :default => 0
  end

  def self.down
  	remove_column :users, :likers_count
  	remove_column :users, :followees_count
  	remove_column :users, :followers_count
  end  
end
