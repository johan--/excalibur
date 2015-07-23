class CompanyProfile < Profile

  typed_store :details do |s|
    s.boolean :public, default: true, null: false
    s.integer :anno, null: false
    s.integer :founding_size
    s.string  :online_presence_types
    s.string  :offline_presence_types
  end

end