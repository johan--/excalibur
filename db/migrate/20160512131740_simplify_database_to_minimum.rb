class SimplifyDatabaseToMinimum < ActiveRecord::Migration
  def self.up
  	drop_table :groups
  	drop_table :group_memberships
  	drop_table :acquisitions
  	drop_table :occupancies
    drop_table :contracts
  end

  def self.down
  	create_table :groups
  	create_table :group_memberships
  	create_table :acquisitions
  	create_table :occupancies  	
    create_table   :contracts
  end  
end