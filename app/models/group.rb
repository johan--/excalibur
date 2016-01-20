class Group < ActiveRecord::Base
  groupify :group
  self.inheritance_column = :fake_column

  def self.groups
    %w(Partnership Business Syndicate)
  end  
end