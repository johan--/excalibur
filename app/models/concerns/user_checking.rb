module UserChecking
  extend ActiveSupport::Concern
  included do

    def email_verified?
      self.email && self.email !~ TEMP_EMAIL_REGEX
    end
    
    # def operator?
    #   return true if self.category == 2
    # end

    # def player?
    #   return true if self.category == 1
    # end

    def has_biz?
      true unless self.teams.biz.count == 0
    end

    def with_no_firm?
      return true if find_firm.nil?
    end

    def find_firm
      self.rosters.first
    end

    def firm_locator
      find_firm.team
    end
    
  end
end