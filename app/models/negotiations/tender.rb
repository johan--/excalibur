class Tender < ActiveRecord::Base
  belongs_to :tenderable, polymorphic: true  
  has_many :bids

  monetize :target_cents
  monetize :contributed_cents

  serialize :properties, HashSerializer
  store_accessor :properties, 
                 :open, :summary, :barcode

  serialize :details, HashSerializer
  store_accessor :details, 
                 :intent_type, :intent_assets, :aqad, :aqad_code

  validates_presence_of :aqad, :summary#, :target, :contributed
  before_create :set_default_values!

  def self.categories
    %w(Bisnis Konsumsi)
  end

  scope :open, -> { 
    where("tenders.properties->>'open' = :true", true: "true") 
  }
  scope :with_aqad, ->(aqad) { 
    where("tenders.details->>'aqad' = :type", type: "#{aqad}") 
  }


private

  def set_default_values!
    self.barcode = "#{created_at}/#{id}"
    self.open = true
  end

end
