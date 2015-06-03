class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer    :category, null:false
      t.references :firm, index: true, null: false
      t.integer    :status, index: true, null: false
      t.date       :start_date, null: false
      t.date       :end_date, null: false

      t.timestamps null: false
    end

  end
end
