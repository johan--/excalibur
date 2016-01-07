class CreateTeamMembers < ActiveRecord::Migration
  def self.up
    create_table :rosters do |t|
      t.references  :rosterable, polymorphic: true, index: true, null: false
      t.references  :teamable, polymorphic: true, index: true, null: false
      t.string      :role
      t.string      :state, null: false
      t.datetime    :deleted_at, index: true

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :rosters
  end
end