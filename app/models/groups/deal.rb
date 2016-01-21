class Deal < Group
  groupify :group, members: [:tenders, :bids], default_members: :tenders
  # # has_many :bids, through: :group_memberships
end