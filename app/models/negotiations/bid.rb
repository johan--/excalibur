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
                 :intent_type, :intent_assets

  validates_presence_of :contribution#, :target, :contributed

  before_create :set_default_values!
  after_create  :touch_tender!

  
private
  def set_default_values!
	  self.state = "belum diproses"
    self.barcode = "Tawaran ##{SecureRandom.hex(3)}"
    self.bidder_name = self.bidder.name
    self.tenderable_name = self.tender.tenderable.name
    self.open = true
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