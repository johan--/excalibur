class CreateTenders < ActiveRecord::Migration
  def change
    create_table :tenders do |t|
      t.references :user, index: true
      t.string :barcode
      t.string :category
      t.string :state, default: "belum diproses"
      t.decimal :total
      t.text :description

      t.timestamps null: false
    end
    add_foreign_key :tenders, :users
  end
end
