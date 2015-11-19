class Bid < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  belongs_to :bidder, polymorphic: true
  belongs_to :tender

  monetize :contribution_sens

  serialize :properties, HashSerializer
  store_accessor :properties, 
                 :open, :summary, :barcode, :bidder_name, :tenderable_name

  serialize :details, HashSerializer
  store_accessor :details, 
                 :intent_type, :intent_assets, :shares, :at_price

  validates_presence_of :contribution#, :target, :contributed

  before_create :set_default_values!
  before_save   :set_contribution!
  after_save  :touch_tender!

  def bidder?(user)
    if self.bidder == user
      return true
    end
  end
  

private
  def set_default_values!
	  if self.state.nil?
      self.state = "belum diproses" 
    end
    self.barcode = "Tawaran ##{SecureRandom.hex(3)}"
    self.bidder_name = self.bidder.name
    self.tenderable_name = self.tender.tenderable.name
    self.open = true
  end

  def set_contribution!
    self.at_price = self.tender.price_per_share
    self.contribution = self.shares.to_i * self.at_price
  end

  def slug_candidates
    [
      [:bidder_name, :barcode]
    ]
  end

  def touch_tender!
    self.tender.touch
  end

end