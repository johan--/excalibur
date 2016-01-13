class CreateTenders < ActiveRecord::Migration
  def self.up
    create_table :tenders do |t|
      t.references :tenderable, polymorphic: true, null: false
      t.references :house, index: true
      t.string     :category, null: false
      t.string     :aqad, null: false, index: true
      t.string     :ticker, index: true
      t.string     :slug, null: false, index: true, unique: true
      t.integer    :annum, null: false
      t.integer    :volume, null: false
      t.monetize   :price, null: false
      # t.monetize :target, null: false
      t.jsonb      :details, null: false, default: {}
      t.datetime   :deleted_at, index: true

      t.timestamps null: false
    end
    change_column :tenders, :price_sens, :bigint, null: false
    add_index :tenders, [:tenderable_type, :tenderable_id]
    add_index :tenders, :details, using: :gin
  end

  def self.down
    drop_table :tenders
  end  
end