class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.references  :rosterable, polymorphic: true, index: true, null: false
      t.references  :user, index: true, null: false
      t.integer     :role
      t.datetime    :deleted_at, index: true

      t.timestamps null: false
    end
    add_index :rosters, [:rosterable_type, :rosterable_id, :user_id]
  end
end
