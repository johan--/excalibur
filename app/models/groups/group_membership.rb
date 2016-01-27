class GroupMembership < ActiveRecord::Base
  groupify :group_membership
  # protokoll :group_name, :pattern => "PAR%y####"
end