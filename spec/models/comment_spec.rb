require 'rails_helper'

RSpec.describe Comment, :type => :model do
  let!(:user) { FactoryGirl.create(:admin) }
  let!(:parent_post) { FactoryGirl.create(:post_with_user) }

  before do
  	@comment = Comment.new(commentable: parent_post, user: user,
  			body_md: "Cech almunia lehmann seaman sczeczny fabianski" )
  end

  subject { @comment }

  it { should respond_to(:user) }
  it { should respond_to(:commentable) }
  # it { should respond_to(:post) }
  it { should respond_to(:title) }
  it { should respond_to(:subject) }

  describe "when saved" do
  	before(:each) { @comment.save }

  	describe "it should be valid" do
  	  it { should be_valid } 
  	end

    it 'has html value of body' do
      expect(@comment.body_html).to_not eq nil
    end

  	describe ".has_children" do
  	  let!(:result) { @comment.has_children? }

  	  it "should return false if it has no children" do
  	  	expect(result).to eq false
  	  end
  	end

  end

end
