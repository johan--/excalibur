class CreateHouses < ActiveRecord::Migration
  def self.up
    create_table :houses do |t|
      t.references :publisher, polymorphic:true, index: true, null: false
      t.monetize   :price, null: false
      t.string     :ticker
      t.string     :state, index: true
      t.string     :address, null: false
      t.float      :longitude
      t.float      :latitude
      t.string 	   :city
      t.jsonb  	   :details, default: {}
      t.text   	   :description
      t.string 	   :avatar
      t.string	   :slug, index: true, unique: true
      t.datetime   :deleted_at, index: true

      t.timestamps null: false
    end
    change_column :houses, :price_sens, :bigint, null: false
  end

  def self.down
    drop_table :houses
  end  
end
