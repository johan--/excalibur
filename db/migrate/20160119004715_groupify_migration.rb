class GroupifyMigration < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string    :type
      t.string    :name, null: false, index: true
      t.string    :slug, index: true
      t.jsonb     :details
    end
    add_index :groups, :details, using: :gin

    create_table :group_memberships do |t|
      t.references :member, polymorphic: true, index: true, null: false
      t.references :group, polymorphic: true, index: true

      # The named group to which a member belongs (if using)
      t.string     :group_name, index: true

      # The membership type the member belongs with
      t.string     :membership_type
      t.jsonb      :details
      t.timestamps  null: false
    end
    add_index :group_memberships, :details, using: :gin
  end

  def self.down
    drop_table :groups
    drop_table :group_memberships
  end
end
