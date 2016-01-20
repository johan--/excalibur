class Stock < ActiveRecord::Base
  extend FriendlyId  
  include WannabeBool::Attributes
  include RefreshSlug
  friendly_id :slug_candidates, use: :slugged
  protokoll :ticker, :pattern => "PRO%y####%m"
  monetize :price_sens

  belongs_to :house
  belongs_to :holder, polymorphic: true
  has_many :tenders, as: :tenderable

  serialize :details, HashSerializer
  store_accessor :details, 
                 :initial, :state, :expired


private

  def slug_candidates
    [:ticker]
  end


end