class CreateTermSheets < ActiveRecord::Migration
  def change
    create_table :term_sheets do |t|
      t.string 		 :category, null: false
      t.string 		 :state
      t.jsonb		   :details
      t.string     :slug, index: true, unique: true, null: false
      t.references :deal, null: false
      t.references :recipient, polymorphic: true, null: false
      t.timestamps null: false
    end
    add_index  :term_sheets, :deal_id
    add_index  :term_sheets, [:recipient_type, :recipient_id]
  end
end
