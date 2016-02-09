class CreateIdentities < ActiveRecord::Migration
  def self.up
    create_table :identities do |t|
      t.references :user, index: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :token, null: false
      t.string  :secret
      t.datetime :expires_at
      t.string  :email
      t.string  :image
      t.string  :nickname
      t.string  :first_name
      t.string  :last_name
      t.string  :location
      t.string  :public_url

      t.timestamps null: false
    end
    add_foreign_key :identities, :users
    add_index :identities, [:user_id, :provider, :uid]
    add_index :identities, [:provider, :uid], :unique => true
  end

  def self.down
    drop_table :identities
  end
end
