class AlterGroupMemberships < ActiveRecord::Migration
  def self.up
    add_reference :rosters, :teamable, polymorphic: true, index: true, null: false
    remove_column :rosters, :team_id, :integer
    add_column    :businesses, :category, :string, index: true, null: false
    add_column    :firms, :category, :string, index: true, null: false
  end
 
  def self.down
    remove_reference :rosters, :teamable, polymorphic: true, index: true, null: false
    add_column :rosters, :team_id, :integer
    remove_column    :businesses, :category, :string, index: true, null: false
    remove_column    :firms, :category, :string, index: true, null: false    
  end
end
