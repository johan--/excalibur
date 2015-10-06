class Subscriber < ActiveRecord::Base
  validates :email, :format => { :with => %r{.+@.+\..+} }, 
  					:allow_blank => true


  scope :whitelist, -> { 
    where(name: "whitelisted") 
  }    

  # Pagination
  paginates_per 50

  def self.last_subscribes(count)
    order(created_at: :desc).limit(count).select("id","email","created_at")
  end

end