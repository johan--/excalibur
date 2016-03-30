class AddSeedCapitalIntoTender < ActiveRecord::Migration
  def self.up
  	add_column :tenders, :seed_capital, :integer
  	add_column :tenders, :deadline, :date
  end

  def self.down
  	remove_column :tenders, :seed_capital
  	remove_column :tenders, :deadline
  end  
end
