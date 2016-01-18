require 'rails_helper'

RSpec.describe Tender, :type => :model do
  let!(:user) { FactoryGirl.create(:user) }

  describe "house purchase tender" do
  	before do
  	  @tender = FactoryGirl.build(:tender, :murabaha,
  	  								:house_purchase, tenderable: user)
  	end

	subject { @tender }

	it { should respond_to(:house) }
	it { should respond_to(:tenderable) }
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
	  	it "sets tender as not a draft" do
	  	  expect(@tender.draft?).to eq false
	  	end

	  	it "sets status" do
	  	  expect(@tender.state).to eq 'open'
	  	end

	  	it "sets slug that is equal to ticker" do
	  	  expect(@tender.slug).to eq @tender.ticker.downcase
	  	end
	  	# it "sets margin" do
	  	#   expect(@tender.margin).to be > 0
	  	# end	  	
	  end

	  describe ".target" do
		it 'returns the target money sens value of target' do
		  expect(@tender.target).to eq 100000000 #plus two zero digits as sens added
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


	  describe "making comments" do
	  	before do
		  @comment = Comment.build_from( @tender, user.id, 
		  	"Hey guys this is my comment!" )
		  @comment.save
		end

		it "should be able to retrieve the comment belonged to the tender" do
		  comments = @tender.comment_threads
		  expect(comments.count).to eq 1
		end
	  end
	end
  end

 #  describe "Musyarakah financing" do
 #  	before do
 #  	  @tender = user.tenders.build(
 #  	  		category: "User", aqad: "musyarakah", use_case: "pembelian",
 #  			intent: "tempat tinggal", own_capital: 30, price: 10000000, 
 #  			maturity: 8, tangible: "rumah tunggal", 
 #  			address: "Lorem ipsum dolor cassus")
 #  	end

	# subject { @tender }

	# it { should respond_to(:tangible) }
	# it { should respond_to(:maturity) }
	# it { should respond_to(:margin) }
	# it { should respond_to(:intent) }
	# it { should respond_to(:aqad) }
	# it { should respond_to(:aqad_code) }
	# it { should be_valid }

	# describe "after save" do
	#   before(:each) { @tender.save }

	#   describe "default values set by callback or database" do
	#   	it "sets margin" do
	#   	  # expect(@tender.margin).to be > 0
	#   	  expect(@tender.margin).to be_between(0, 10).inclusive
	#   	end	  	
	#   end

	#   describe ".price" do
	# 	it 'returns the price of the property' do
	# 	  expect(@tender.price).to eq 10000000
	# 	end
	#   end

	#   describe ".target" do
	# 	it 'returns the target money sens value of target' do
	# 	  expect(@tender.target_sens).to eq 700000000 #plus two zero digits as sens added
	# 	end
	#   end

	# end
 #  end


 #  describe "scoping tender" do
 #  	let!(:tender_1) { FactoryGirl.create(:consumer_tender, :musharakah, tenderable: user) }
 #  	let!(:tender_2) { FactoryGirl.create(:consumer_tender, :musharakah, tenderable: user) }
 #  	let!(:tender_3) { FactoryGirl.create(:consumer_tender, :murabahah, tenderable: user) }

 #  	describe "Tender.open" do
	#   let!(:result) { Tender.open }

	#   it "returns tender that has open attribute set to true" do
	#   	expect(result.count).to eq 3
	#   end
 #  	end

 #  	describe "Tender.with_aqad(aqad)" do
	#   let!(:result) { Tender.with_aqad('murabahah') }

	#   it "returns tender that has murabahah as aqad" do
	#   	expect(result.count).to eq 1
	#   end
 #  	end
 #  end

 #  describe "when there is a bid" do
 #  	let!(:user_1) { FactoryGirl.create(:financier) }
 #  	let!(:tender) { FactoryGirl.create(:consumer_tender, :murabahah, tenderable: user) }
 #  	let!(:bid) { FactoryGirl.create(:bid, bidder: user_1, tender: tender) }
	
	# # subject { tender }

 #  	describe "tender.bids" do
	#   it "returns tender that has open attribute set to true" do
	#   	expect(tender.bids.count).to eq 1
	#   end
 #  	end

 #  	describe "tender.contribution" do
	#   let!(:result) { tender.contributed }

	#   it "returns tender that has open attribute set to true" do
	#   	expect(result).to eq bid.contribution
	#   end
 #  	end

 #  end

end