class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references  :subscription, index: true, null: false
      t.string      :pay_code, index: true, null: false
      t.datetime    :pay_day, null: false
      t.integer     :total, null: false

      t.timestamps null: false
    end
  end
end
