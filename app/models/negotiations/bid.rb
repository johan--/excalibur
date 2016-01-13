class Bid < ActiveRecord::Base
  extend FriendlyId
  include WannabeBool::Attributes
  protokoll :ticker, :pattern => "BID%y%m%d####"
  friendly_id :slug_candidates, use: :slugged
  belongs_to :bidder, polymorphic: true
  belongs_to :tender

  monetize :price_sens

  serialize :details, HashSerializer
  store_accessor :details, 
                 :draft, :state, :message, :intent_type, :intent_assets

  attr_wannabe_bool :draft
  validates_presence_of :price, :volume

  before_create :set_default_values!
  after_save  :touch_tender!, if: ->(obj){ obj.volume.present? and obj.volume_changed? }

  def bidder?(user)
    if self.bidder == user
      return true
    end
  end
  
  def contribution
    price * volume
  end

private
  def set_default_values!
	  self.state = "pending" if self.state.nil?
    self.draft = "no" if self.draft.nil?
    self.price = self.tender.price# if self.price.nil?
  end

  def touch_tender!
    self.tender.touch
  end

  def slug_candidates
    [:ticker]
  end
end