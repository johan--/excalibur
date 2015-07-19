class CreateGroups < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string   :type, null: false # Only needed if using single table inheritance
      t.string   :name
      t.string   :starter_email, null: false
      t.string   :starter_phone
    end
    add_index :teams, :type
    add_index :teams, :name
    add_index :teams, :starter_email

    create_table :rosters do |t|
      t.references  :rosterable, polymorphic: true, index: true, null: false
      t.references  :team, index: true, null: false
      t.integer     :role, null: false
      t.string      :state, null: false, default: "aktif"
      t.datetime    :deleted_at, index: true

      t.timestamps null: false
    end
    add_index :rosters, [:rosterable_type, :rosterable_id, :team_id]
  end
end
