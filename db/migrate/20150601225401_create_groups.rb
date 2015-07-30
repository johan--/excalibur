class CreateGroups < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references  :teamable, polymorphic: true, null: false
      t.string      :category, null: false
      t.jsonb       :data, null: false, default: {}
      t.datetime    :deleted_at, index: true

      t.timestamps null: false
    end
    add_index :teams, [:teamable_type, :teamable_id]
    add_index :teams, :category
    add_index  :teams, :data, using: :gin

    create_table :rosters do |t|
      t.references  :rosterable, polymorphic: true, index: true, null: false
      t.references  :team, index: true, null: false
      t.integer     :role, null: false
      t.string      :state, null: false, default: "aktif"
      t.datetime    :deleted_at, index: true

      t.timestamps null: false
    end
    add_index :rosters, [:rosterable_type, :rosterable_id, :team_id], unique: true
  end
end
