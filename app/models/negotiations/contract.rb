class Contract < ActiveRecord::Base
  extend FriendlyId
  include RefreshSlug
  acts_as_paranoid
  friendly_id :slug_candidates, use: :slugged
  protokoll :ticker, :pattern => "PRO%y####%m"

  belongs_to :tender
  
  attr_accessor :image_id
  serialize :details, HashSerializer



private
  def slug_candidates
    [:ticker]
  end
end