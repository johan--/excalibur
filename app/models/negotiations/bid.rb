class Bid < ActiveRecord::Base
  extend FriendlyId
  include WannabeBool::Attributes
  include RefreshSlug
  acts_as_paranoid
  protokoll :ticker, :pattern => "BID%y%m%d####"
  friendly_id :slug_candidates, use: :slugged

  groupify :group_member
  groupify :named_group_member
  belongs_to :bidder, polymorphic: true
  belongs_to :tender

  monetize :price_sens

  serialize :details, HashSerializer
  store_accessor :details, 
                 :starter, :draft, :state, :message, 
                 :last_volume, :installments

  attr_wannabe_bool :draft, :starter
  validates_presence_of :price, :volume
  validates_associated :tender

  before_create :set_default_values!
  after_create :refresh_friendly_id!
  after_save  :touch_tender!, if: ->(obj){ obj.volume_changed? }
  before_destroy :reset_volume

  scope :real, -> { where(deleted_at: nil) }
  scope :starter, -> { where("bids.details->>'starter' = :type", type: "yes").first  }

  def bidder?(user)
    if self.bidder == user
      return true
    end
  end
  
  def contribution
    price * volume
  end

  def reset_volume
    vol = self.volume
    update(volume: 0, last_volume: vol)
  end

private
  def set_default_values!
	  self.state = "pending" if self.state.nil?
    self.draft = "no" if self.draft.nil?
    self.price = self.tender.price# if self.price.nil?
  end

  def touch_tender!
    self.tender.touch
    # Tender.find_by_id(self.tender.id).touch
  end

  def slug_candidates
    [:ticker]
  end


end