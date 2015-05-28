class CreateReservationTransitions < ActiveRecord::Migration
  def change
    create_table :reservation_transitions do |t|
      t.string :to_state, null: false
      t.text :metadata, default: "{}"
      t.integer :sort_key, null: false
      t.integer :reservation_id, null: false
      t.boolean :most_recent, null: false
      t.timestamps null: false
    end

    add_index(:reservation_transitions,
              [:reservation_id, :sort_key],
              unique: true,
              name: "index_reservation_transitions_parent_sort")
    add_index(:reservation_transitions,
              [:reservation_id, :most_recent],
              unique: true,
              where: 'most_recent',
              name: "index_reservation_transitions_parent_most_recent")
  end
end
