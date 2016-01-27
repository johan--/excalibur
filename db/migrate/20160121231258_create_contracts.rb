class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.references :tender, index: true, null: false
      t.string     :type
      t.string     :ticker, null: false
      t.string     :slug, index: true, unique: true
      t.jsonb      :details
      t.date       :begin_at
      t.date       :end_at
      t.datetime   :deleted_at, index: true

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :contracts
  end
end