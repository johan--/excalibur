class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.string  :liker_type, null: false
      t.integer :liker_id, null: false
      t.string  :likeable_type, null: false
      t.integer :likeable_id, null: false
      t.datetime :created_at
    end

    add_index :likes, ["liker_id", "liker_type"],       :name => "fk_likes"
    add_index :likes, ["likeable_id", "likeable_type"], :name => "fk_likeables"
  end
end
