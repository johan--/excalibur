class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :profile, index: true, null: false
      t.string :name
      t.json :full_address, default: {}, null: false
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :addresses, [:created_at, :profile_id]
  end
end
