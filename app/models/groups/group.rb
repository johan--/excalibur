class Group < ActiveRecord::Base
  extend FriendlyId
  include RefreshSlug
  friendly_id :slug_candidates, use: :slugged
  groupify :group
  # self.inheritance_column = :fake_column

  serialize :details, HashSerializer

  def self.groups
    %w(Deal Business Syndicate)
  end  

  def slug_candidates
    [ :name ]
  end   
end