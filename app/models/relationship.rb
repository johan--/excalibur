class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User", foreign_key: 'follower_id'
  belongs_to :followed, polymorphic: true

  scope :venues, -> { where(followed_type: 'Venue') }
  scope :persons, -> { where(followed_type: 'User') }
  # scope :teams, -> { where(followed_type: 'Team') }
  scope :by_user, ->(user_id) { where(follower_id: user_id) }
end
