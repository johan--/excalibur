class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :email, null: false, index: true
      t.string :name
      t.string :category, null: false, index: true

      t.timestamps null: false
    end
  end
end
