class CreateInstallments < ActiveRecord::Migration
  def change
    create_table :installments do |t|
      t.references :reservation, index: true, null:false
      t.references :user, index: true, null:false
      t.string     :pay_code, index:true, null: false
      t.datetime   :pay_day, null: false
      t.time       :pay_time, null: false
      t.integer    :total, null: false

      t.timestamps null: false
    end
    add_index :installments, [:reservation_id, :pay_code], unique: true
    add_index :installments, [:reservation_id, :pay_day, :pay_time], unique: true
    add_index :installments, [:reservation_id, :user_id]
  end
end
