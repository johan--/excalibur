class RemoveNullConditionsOnHouses < ActiveRecord::Migration
  def self.up
  	change_column_null(:houses, :price_sens, true)
  	remove_column :houses, :address
  	remove_column :houses, :state
  	remove_column :houses, :city
  	add_column 	  :houses, :location, :jsonb
  	add_column 	  :houses, :condition, :jsonb
  end

  def self.down
	change_column_null(:houses, :price_sens, false)  	
	add_column :houses, :address, :string
	add_column :houses, :state, :string
	add_column :houses, :city, :string
	remove_column :houses, :location
	remove_column :houses, :condition
  end  
end
