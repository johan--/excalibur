class Tender < ActiveRecord::Base
  belongs_to :user
  has_many :bids

  before_create :set_barcode

private
  def set_barcode
  	barcode = "#{created_at}/#{id}"
  end


end
