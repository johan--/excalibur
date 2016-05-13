# class Acquisition < ActiveRecord::Base
#   extend FriendlyId
#   protokoll :slug, :pattern => "ACQ%y####"
#   friendly_id :slug, use: :slugged
#   belongs_to :bid
#   belongs_to :acquireable, polymorphic: true
#   belongs_to :benefactor, polymorphic: true

#   serialize :details, HashSerializer
#   # store_accessor :details, 
#   #                :starter, :draft, :state, :message, 
#   #                :last_volume, :installments  
# end
