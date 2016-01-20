class Occupancy < ActiveRecord::Base
  belongs_to :house
  belongs_to :holder
end