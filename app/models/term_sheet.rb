class TermSheet < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  belongs_to :deal
  belongs_to :recipient, polymorphic: true

  serialize :details, HashSerializer
  store_accessor :details, 
                 :aqad, :barcode, :return, :share, 
                 :return_type, :expensed
end
