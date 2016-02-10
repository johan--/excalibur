class CreateBidTransitions < ActiveRecord::Migration
  def change
    create_table :bid_transitions do |t|
      t.string :to_state, null: false
      t.text :metadata, default: "{}"
      t.integer :sort_key, null: false
      t.integer :bid_id, null: false
      t.boolean :most_recent, null: false
      t.timestamps null: false
    end

    add_index(:bid_transitions,
              [:bid_id, :sort_key],
              unique: true,
              name: "index_bid_transitions_parent_sort")
    add_index(:bid_transitions,
              [:bid_id, :most_recent],
              unique: true,
              where: 'most_recent',
              name: "index_bid_transitions_parent_most_recent")
  end
end
