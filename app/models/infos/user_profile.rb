class UserProfile < Profile

  typed_store :details do |s|
    s.boolean :public, default: true, null: false
    s.string  :last_education
    s.string  :marital_status
    s.string    :work_experience#, array: true, default: []
    s.string    :industry_experience#, array: true, default: []

    # In addition to prevent null values you can prevent blank values
    # s.string :title, blank: false, default: 'Title'
  end

end