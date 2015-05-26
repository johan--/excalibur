class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string      :name, null: false
      t.string      :address, null: false
      t.string      :phone
      t.references  :firm, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :venues, :firms
  end
end
