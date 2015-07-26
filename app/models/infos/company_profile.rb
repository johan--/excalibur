class CompanyProfile < Profile

  typed_store :details, coder: DumbCoder do |s|
    s.boolean :public, default: true, null: false
    s.integer :anno, null: false
    s.integer :founding_size
    s.string  :online_presence_types, array: true, default: []
    s.string  :offline_presence_types, array: true, default: []
  end
  # serialize :online_presence_types, Array
  # serialize :offline_presence_types, Array

end