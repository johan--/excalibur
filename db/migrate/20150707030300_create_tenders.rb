class CreateTenders < ActiveRecord::Migration
  def change
    create_table :tenders do |t|
      t.references :tenderable, polymorphic: true, null: false
      t.string :category, null: false
      t.string :state, default: "belum diproses", null: false
      t.monetize :target, null: false
      t.monetize :contributed, default: 0
      t.jsonb :properties, null: false, default: {}
      t.jsonb :details, null: false, default: {}

      t.timestamps null: false
    end
    add_index :tenders, [:tenderable_type, :tenderable_id]
    add_index :tenders, :state
    add_index :tenders, :category
    add_index :tenders, :details, using: :gin
    add_index :tenders, :properties, using: :gin
  end
end
