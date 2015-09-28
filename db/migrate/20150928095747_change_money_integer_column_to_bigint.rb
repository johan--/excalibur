class ChangeMoneyIntegerColumnToBigint < ActiveRecord::Migration
  def self.up
    change_column :tenders, :target_sens, :bigint, default: 0, null: false
    change_column :tenders, :contributed_sens, :bigint, default: 0, null: false
    change_column :bids, :contribution_sens, :bigint, default: 0, null: false
  end
 
  def self.down
    change_column :tenders, :target_sens, :integer
    change_column :tenders, :contributed_sens, :integer
    change_column :bids, :contribution_sens, :integer
  end
end
