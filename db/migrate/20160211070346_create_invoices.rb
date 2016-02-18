class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references 	:invoiceable, polymorphic: true, null: false
      t.references	:recipient, polymorphic: true
      t.monetize	:amount
      t.string		:ticker
      t.string		:category
      t.string		:state
      t.date		:deadline
      t.jsonb		:details
      t.datetime	:deleted_at, index: true
      t.timestamps null: false
    end
    change_column :invoices, :amount_sens, :bigint, null: false
  end
end
