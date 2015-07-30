class Bid < ActiveRecord::Base
  belongs_to :bidder, polymorphic: true
  belongs_to :tender

  monetize :contribution_cents

  serialize :properties, HashSerializer
  store_accessor :properties, 
                 :open, :summary, :barcode

  serialize :details, HashSerializer
  store_accessor :details, 
                 :intent_type, :intent_assets, :aqad, :aqad_code

  before_create :set_default_values!


private
  def set_default_values!
	self.state = "belum diproses"
    self.barcode = "#{created_at}/#{id}"
    self.open = false
  end                 

end