require 'rails_helper'

RSpec.describe Group, :type => :model do

  describe "syndicate (syirkah)" do
  	before { @syndicate = Syndicate.new }

  	subject { @syndicate }

  	it { should respond_to(:group_memberships) }
  	it { should respond_to(:users) }
  	it { should_not respond_to(:tenders) }
  	it { should_not respond_to(:bids) }  	
  end

  describe "syndicate (syirkah)" do
  	before { @deal = Deal.new }

  	subject { @deal }

  	it { should respond_to(:group_memberships) }
  	it { should_not respond_to(:users) }
  	it { should respond_to(:tenders) }
  	it { should respond_to(:bids) }
  end
end
