class UserProfile < Profile
  # serialize :details, JSON

  typed_store :details, coder: DumbCoder do |s|
    s.boolean :public, default: true, null: false
    s.string  :last_education
    s.string  :marital_status
    s.string    :work_experience#, array: true, default: []
    s.string    :industry_experience#, array: true, default: []
  end

end