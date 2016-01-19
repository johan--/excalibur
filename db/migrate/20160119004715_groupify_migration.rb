class GroupifyMigration < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string     :type
    end

    create_table :group_memberships do |t|
      t.references :member, polymorphic: true, index: true, null: false
      t.references :group, polymorphic: true, index: true

      # The named group to which a member belongs (if using)
      t.string     :group_name, index: true

      # The membership type the member belongs with
      t.string     :membership_type

      t.timestamps  null: false
    end
  end

  def self.down
    drop_table :groups
    drop_table :group_memberships
  end
end
