class Occupancy < ActiveRecord::Base
  extend FriendlyId  
  include WannabeBool::Attributes
  include RefreshSlug
  protokoll :ticker, :pattern => "PRO%y####%m"
  friendly_id :slug_candidates, use: :slugged  
  monetize :annual_rental_sens

  belongs_to :house
  belongs_to :holder, polymorphic: true

  def slug_candidates
    [:ticker]
  end  
end