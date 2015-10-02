require 'rails_helper'

RSpec.describe Document, :type => :model do
  let!(:user) { FactoryGirl.create(:client) }
  before(:each) do
  	@document = Document.create(name: 'KTP Jimmy', category: 'Identitas', 
  		public_id: 'asset/default-avatar-sm', owner: user)
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
  	# before(:each) { @document.save }

  	it "has current_state of 'uploaded'" do
      expect(@document.state).to eq 'uploaded'
  	end

    it "has checked att set to false" do
      expect(@document.checked).to eq false
    end

    it "has flagged att set to false" do
      expect(@document.flagged).to eq false
    end

  	it "has association with correct user as owner" do
      expect(@document.owner).to eq user
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
        expect(@document.state).to eq 'verified'
  		end
  	end

  	describe "flagging an upload" do
  		before do 
        @document.flagged = true
        @document.transitioning!
      end

  		it "transitions the document into flagged state" do
  			expect(@document.state).to eq 'flagged'
  		end

  		describe "then later verifying it" do
  			before do 
          @document.checked = true
          @document.flagged = false
          @document.transitioning!
        end

			  it "transitions the document into verified state" do
	  			expect(@document.state).to eq 'verified'
	  		end  			
  		end

  		describe "then later dropping the document" do
  			before do 
          @document.checked = true
          @document.flagged = true
          @document.transitioning!
        end
  			
			it "transitions the document into dropped state" do
	  			expect(@document.state).to eq 'dropped'
	  		end  			
  		end  		
  	end
  end

end
