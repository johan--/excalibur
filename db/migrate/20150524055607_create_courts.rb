class CreateCourts < ActiveRecord::Migration
  def change
    create_table :courts do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.string  :unit, null: false
      t.integer :category, null: false
      t.integer :rating, null: false, default: 0
      t.references :venue, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :courts, :venues
  end
end
