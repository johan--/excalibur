require 'rails_helper'

RSpec.describe Document, :type => :model do
  let!(:user) { FactoryGirl.create(:client) }
  before(:each) do
  	@document = Document.new(name: 'KTP Jimmy', category: 'Identitas', 
  		public_id: 'default-avatar_q1ts3i', owner: user)
  end

  subject { @document }

  it { should respond_to(:bytes) }
  it { should respond_to(:image_id) }
  it { should respond_to(:checked) }
  it { should respond_to(:flagged) }
  it { should respond_to(:owner) }
  it { should respond_to(:state) }

  it { should respond_to(:can_transition_to?) }
  it { should respond_to(:transition_to!) }
  it { should respond_to(:transition_to) }
  it { should respond_to(:current_state) }
  it { should respond_to(:state_machine) }
  it { should be_valid }

  describe "when saved" do
  	before(:each) { @document.save }

  	it "has current_state of 'uploaded'" do
  		@document.state == 'uploaded'
  	end

  	it "has association with correct user as owner" do
  		@document.owner.should == user
  	end
  end

  describe "transitions" do
  	before(:each) do
  		@document.save
  	end

  	describe "verifying an upload" do
  		before do 
        @document.checked = true
        @document.transitioning!
      end

		  it "transitions the document into verified state" do
  			@document.state.should == 'verified'
  		end
  	end

  	describe "flagging an upload" do
  		before do 
        @document.flagged = true
        @document.transitioning!
      end

  		it "transitions the document into flagged state" do
  			@document.state.should == 'flagged'
  		end

  		describe "then later verifying it" do
  			before do 
          @document.checked = true
          @document.flagged = false
          @document.transitioning!
        end

			  it "transitions the document into verified state" do
	  			@document.state.should == 'verified'
	  		end  			
  		end

  		describe "then later dropping the document" do
  			before do 
          @document.checked = true
          @document.flagged = true
          @document.transitioning!
        end
  			
			it "transitions the document into verified state" do
	  			@document.state.should == 'dropped'
	  		end  			
  		end  		
  	end
  end

end