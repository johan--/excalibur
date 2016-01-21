class Group < ActiveRecord::Base
  groupify :group
  # self.inheritance_column = :fake_column

  def self.groups
    %w(Deal Business Syndicate)
  end  
end