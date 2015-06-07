class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :firm, null: false
      t.integer    :category, index: true, null:false
      t.string     :state, index: true, null: false
      t.date       :start_date, null: false
      t.date       :end_date, null: false

      t.timestamps null: false
    end
    add_index :subscriptions, :firm_id, unique: true
    add_index :subscriptions, [:firm_id, :state]
  end
end
