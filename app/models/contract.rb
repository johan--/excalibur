class Contract < ActiveRecord::Base
  belongs_to :house
  belongs_to :bid
end
