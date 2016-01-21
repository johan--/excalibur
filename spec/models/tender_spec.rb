require 'rails_helper'

RSpec.describe Tender, :type => :model do
  let!(:user) { FactoryGirl.create(:user) }

  describe "fundraising for murabaha house purchase" do
  	before do
  	  @tender = FactoryGirl.build(:house_purchase_murabaha_tender, 
  	  								starter: user)
  	end

	subject { @tender }

	it { should respond_to(:tenderable) }
	it { should respond_to(:starter) }
	it { should respond_to(:comment_threads) }
	it { should respond_to(:ticker) }
	it { should respond_to(:category) }
	it { should respond_to(:target) }
	it { should respond_to(:price_sens) }
	it { should respond_to(:details) }
	it { should respond_to(:unit) }
	it { should respond_to(:state) }
	it { should respond_to(:draft) }
	it { should respond_to(:aqad_code) }
	it { should be_valid }

	describe "after save" do
	  before(:each) { @tender.save }

	  describe "default values set by callback or database" do
	  	it "has the tenderable" do
	  	  expect(@tender.tenderable).to_not eq nil
	  	end

	  	it "sets tender as not a draft" do
	  	  expect(@tender.draft?).to eq false
	  	end

	  	it "sets status" do
	  	  expect(@tender.state).to eq 'open'
	  	end

	  	it "sets slug that is equal to ticker" do
	  	  expect(@tender.slug).to eq @tender.ticker.downcase
	  	end

	  	it "sets the same price as the initial stock" do
	  	  expect(@tender.price).to eq @tender.tenderable.house.price / 1000
	  	end
	  	# it "sets margin" do
	  	#   expect(@tender.margin).to be > 0
	  	# end	  	
	  end

	  describe ".target" do
		it 'returns the target money sens value of target' do
		  expect(@tender.target).to eq 300000000 #plus two zero digits as sens added
		end
	  end

	  describe "determining access and authorization for a tender" do
	  	describe ".access_granted?(user)" do
	  	  it "determines whether a user is has permission to alter proposal" do
	  	  	result = @tender.access_granted?(user)
	  	  	expect(result).to eq true
	  	  end
	  	end
	  	
	  	describe ".tender_owner?(user)" do
	  	  it "determines whether a user is a tender owner" do
	  	  	result = @tender.tender_owner?(user)
	  	  	expect(result).to eq true
	  	  end
	  	end
	  end


	 #  describe "making comments" do
	 #  	before do
		#   @comment = Comment.build_from( @tender, user.id, 
		#   	"Hey guys this is my comment!" )
		#   @comment.save
		# end

		# it "should be able to retrieve the comment belonged to the tender" do
		#   comments = @tender.comment_threads
		#   expect(comments.count).to eq 1
		# end
	 #  end
	end
  end

  describe "fundraising for musharaka house purchase" do
	before { @tender = FactoryGirl.build(:house_purchase_musharaka_tender, 
  	  								starter: user) }
	subject { @tender }	

	it { should be_valid }
  end


  describe "scoping tender" do
  	let!(:tender_1) { FactoryGirl.create(:house_purchase_murabaha_tender) }
  	let!(:tender_2) { FactoryGirl.create(:house_purchase_musharaka_tender) }
  	let!(:tender_3) { FactoryGirl.create(:musharaka_share_sale) }

  	describe "Tender.open" do
	  let!(:result) { Tender.offering }

	  it "returns tender that is fundraising" do
	  	expect(result.count).to eq 2
	  end
  	end

  	describe "Tender.with_aqad(aqad)" do
	  let!(:result) { Tender.with_aqad('murabaha') }

	  it "returns tender that has murabahah as aqad" do
	  	expect(result.count).to eq 1
	  end
  	end
  end

end