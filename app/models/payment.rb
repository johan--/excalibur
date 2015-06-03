class Payment < ActiveRecord::Base
  belongs_to :subscription
  validates_associated :subscription

  validates_presence_of :pay_code, :total, :pay_day
end
