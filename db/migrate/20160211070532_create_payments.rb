class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :invoice, index: true
      t.references :sender, polymorphic: true, index: true
      t.monetize   :amount, null: false
      t.string		:ticker
      t.string		:state
	  t.jsonb		:details      
      t.timestamps null: false
    end
    change_column :payments, :amount_sens, :bigint, null: false
  end
end
