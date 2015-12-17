class TermSheet < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  belongs_to :deal
  belongs_to :recipient, polymorphic: true

  serialize :details, HashSerializer
  store_accessor :details, 
                 :title, :legal_code, :barcode, :return, :share, 
                 :return_type, :expensed, :dealer, :executor

  before_create :set_slug


private
  def set_return_type
  	if aqad == 'murabahah'
  	  self.return_type = 'Profit'
  	elsif aqad == 'ijarah'
  	  self.return_type = 'Rent'
  	elsif aqad == 'mudharabah' || aqad == 'musyarakah'
  	  self.return_type = 'Dividend'
  	end
  end

  def set_slug
  	self.slug = "Kontrak #{category} Untuk #{recipient.name}"
  end

  def slug_candidates
    [ :title ]
  end

end