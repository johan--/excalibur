class Bid < ActiveRecord::Base
  belongs_to :tender, polymorphic: true
  
  
end
