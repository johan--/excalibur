class Subscriber < ActiveRecord::Base
  validates :email, :format => { :with => %r{.+@.+\..+} }, 
  					:allow_blank => true

  def self.last_subscribes(count)
    order(created_at: :desc).limit(count).select("id","email","created_at")
  end

end