class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date 		    :date_reserved, null: false
      t.time 		    :start, null: false
      t.decimal     :duration, null: false
      t.time 		    :finish, null: false
      t.integer     :charge, null: false
      t.string      :state, null: false
      t.references 	:court, index: true, null: false
      t.references 	:booker, polymorphic: true, index: true, null: false
      t.timestamps null: false
    end
    add_index :reservations, [:booker_id, :booker_type, :court_id]
    add_index :reservations, [:court_id, :date_reserved, :start]
    add_index :reservations, [:date_reserved, :start, :finish]
  end
end
