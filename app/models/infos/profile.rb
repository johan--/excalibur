class Profile < ActiveRecord::Base
  include DumbCoder

  self.inheritance_column = :category
  
  belongs_to :profileable, polymorphic: true
  has_many :addresses


  def self.categories
    %w(UserProfile CompanyProfile)
  end

end
