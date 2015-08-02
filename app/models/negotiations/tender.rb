class Tender < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  belongs_to :tenderable, polymorphic: true  
  
  has_many :bids

  monetize :target_cents
  monetize :contributed_cents

  serialize :properties, HashSerializer
  store_accessor :properties, 
                 :open, :category, 
                 :summary, :barcode, :tenderable_name

  serialize :details, HashSerializer
  store_accessor :details, 
                 :intent_type, :intent_assets, :aqad, :aqad_code

  validates_presence_of :aqad, :summary#, :target, :contributed
  before_create :set_default_values!

  def self.categories
    %w(Institusi Bisnis Individu)
  end

  scope :open, -> { 
    where("tenders.properties->>'open' = :true", true: "true") 
  }
  scope :with_aqad, ->(aqad) { 
    where("tenders.details->>'aqad' = :type", type: "#{aqad}") 
  }


private
  def set_default_values!
    self.state = "menunggu tawaran"
    self.barcode = "Proposal ##{SecureRandom.hex(3)}"
    self.tenderable_name = self.tenderable.name
    self.open = true
  end

  def slug_candidates
    [ 
      :barcode,
      [:tenderable_name, :aqad, :barcode]
    ]
  end
end
