class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references  :subscription, null: false, index: true
      t.string      :pay_code, null: false
      t.date        :pay_day, null: false
      t.time        :pay_time, null: false
      t.integer     :total, null: false

      t.timestamps null: false
    end
    add_index	:payments, [:subscription_id, :pay_code], unique: true
    add_index :payments, [:subscription_id, :pay_day], unique: true
  end
end
