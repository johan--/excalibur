class CreateFirms < ActiveRecord::Migration
  def change
    create_table :firms do |t|
      t.string      :name, index: true, null: false
      t.string      :city, index: true, null: false
      t.string      :address, null: false
      t.string      :phone, null: false

      t.timestamps null: false
    end
  end
end
