class Syndicate < Group
  has_members :users
  # # has_many :bids, through: :group_memberships
end