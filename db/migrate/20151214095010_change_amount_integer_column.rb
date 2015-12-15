class ChangeAmountIntegerColumn < ActiveRecord::Migration
  def self.up
    change_table :deals do |t|
      t.change :amount_sens, :bigint, default: 0, null: false
    end
  end
 
  def self.down
    change_table :deals do |t|
      t.change :amount_sens, :integer
    end
  end  
end
