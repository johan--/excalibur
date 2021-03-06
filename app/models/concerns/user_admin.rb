module UserAdmin
  extend ActiveSupport::Concern
  included do

  # admin methods
    def self.paged(page_number)
      order(admin: :desc, email: :asc).page page_number
    end

    def self.search_and_order(search, page_number)
      if search
        where("email LIKE ?", "%#{search.downcase}%").order(
        admin: :desc, email: :asc
        ).page page_number
      else
        order(admin: :desc, email: :asc).page page_number
      end
    end

    def self.last_signups(count)
      order(created_at: :desc).limit(count).select("id","email","created_at")
    end

    def self.last_signins(count)
      order(last_sign_in_at:
      :desc).limit(count).select("id","email","last_sign_in_at")
    end

    def self.users_count
      where("admin = ? AND locked = ?",false,false).count
    end
    
  end
end