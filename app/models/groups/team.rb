# class Team < ActiveRecord::Base
#   has_many :rosters
#   has_many :users, through: :rosters, source: :rosterable, source_type: 'User'
#   belongs_to :teamable, polymorphic: true

#   serialize :data, HashSerializer
#   store_accessor :data, 
#               :name, :starter_email, :starter_phone, :starter_name

#   validates :name, :presence => true
#   validates :category, :presence => true

#   after_create :starting_up
  
#   scope :biz, -> { where(teamable_type: 'Business') }
  
#   def self.categories
#     %w(Business Firm)
#   end

#   def starter
#     starter = User.find_by(email: starter_email)
#   end

#   def has_as_member?(roster)
#     if self.rosters.find_by(rosterable_id: roster.id, rosterable_type: roster.class.name)
#       return true
#     else 
#       return false
#     end
#   end

#   def find_tenders
#     check = Tender.where(tenderable_type: self.class.name, tenderable_id: id)
#     if check.nil? || check.count == 0
#       return nil
#     else
#       return check
#     end
#   end



# private

#   def starting_up
#     unless starter.nil?
#       starter_name = starter.name
#       starter_phone = starter.phone_number    
#       roster = self.rosters.build(rosterable: starter, 
#                                 role: 0, state: "aktif")
#       roster.save!
#     end
#   end

# end