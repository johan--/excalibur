class Installment < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :user
  validates_presence_of :pay_code, :total, :pay_day
end
