class Deal < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  monetize :amount_sens
  
  belongs_to :tender
  has_many :rosters, as: :teamable
  accepts_nested_attributes_for :rosters, reject_if: :all_blank, allow_destroy: true
  # has_many   :term_sheets
  # has_many   :users, through: :term_sheets, source: :recepient, source_type: 'User'

  serialize :details, HashSerializer
  store_accessor :details, 
                 :title, :barcode, :maturity, :aqad

  before_create :set_default_values!

private
  def set_default_values!
    self.state = 'draft'
    self.barcode = "##{SecureRandom.hex(3)}"
    self.maturity = self.tender.maturity
    self.aqad = self.tender.aqad
  end

  def slug_candidates
    [ 
      :barcode
    ]
  end

end
