class RejigHouseTableColumns < ActiveRecord::Migration
  def self.up
  	add_column :houses, :address, :string
  	add_column :houses, :city, :string
  	add_column :houses, :followers_count, :integer, :default => 0
  	add_index  :houses, [:address, :city], unique: true
  end

  def self.down
  	remove_column :houses, :address
  	remove_column :houses, :city
  	remove_column :houses, :followers_count, :integer, :default => 0
  	remove_index  :houses, [:address, :city], unique: true
  end  
end