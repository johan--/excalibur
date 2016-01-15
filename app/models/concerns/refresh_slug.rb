module RefreshSlug
  extend ActiveSupport::Concern
  included do
  
    def refresh_friendly_id!
      update(slug: nil)
    end

  end
end