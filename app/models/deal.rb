class Deal < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  monetize :amount_sens
  
  belongs_to :tender
  has_many :rosters, as: :teamable
  has_many :users, through: :rosters, source: :rosterable, source_type: 'User'
  has_many   :term_sheets

  serialize :details, HashSerializer
  store_accessor :details, 
                 :barcode, :maturity, :aqad

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
