class Deal < ActiveRecord::Base
  # groupify :group
  groupify :group, members: [:users]
  acts_as_group
  has_many :group_memberships, as: :group
  # has_many :bids, through: :group_memberships
end
