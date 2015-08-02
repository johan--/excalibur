class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user, index: true
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps null: false
    end
    add_foreign_key :identities, :users
    add_index :identities, [:user_id, :provider, :uid]
  end
end
