class CreateStockOwnerships < ActiveRecord::Migration
  def self.up
    create_table :stocks do |t|
      t.references :house, index: true, null: false
      t.references :holder, polymorphic: true, index: true, null: false
      t.string     :category, null: false, index: true
      t.string     :slug, index: true
      t.string     :ticker
      t.boolean    :tradeable, null: false, index: true
      t.monetize   :price, null: false
      t.integer    :volume, null: false
      t.jsonb      :details
      t.datetime   :deleted_at, index: true

      t.timestamps null: false
    end
    change_column :stocks, :price_sens, :bigint, null: false

    create_table :occupancies do |t|
      t.references :house, index: true, null: false
      t.references :holder, polymorphic: true, index: true
      t.string     :slug, index: true
      t.string     :ticker      
      t.boolean    :rental, null: false
      t.integer    :annum, null: false
      t.monetize   :annual_rental
      t.boolean    :tradeable
      t.jsonb      :details
      t.datetime   :deleted_at, index: true

      t.timestamps null: false
    end
    change_column :occupancies, :annual_rental_sens, :bigint, null: false
  end

  def self.down
    drop_table :stocks
    drop_table :occupancies
  end
end