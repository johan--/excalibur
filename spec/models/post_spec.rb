require 'rails_helper'

RSpec.describe Post, :type => :model do
  let!(:user) { FactoryGirl.create(:admin) }

  before(:each) do
  	@post = Post.new(title: "Test Post Numero Uno", draft: true, user: user,
  		content_md: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor",
  		topic: "Dummy", tags: ['lorem', 'indonesia'])
  end

  subject { @post }

  it { should respond_to(:content_html) }
  it { should respond_to(:slug) }
  it { should respond_to(:header) }
  it { should respond_to(:keywords) }
  it { should respond_to(:topic) }
  it { should respond_to(:tags) }

  it { should be_valid }

  describe "when saved" do
  	before(:each) { @post.save }

  	describe ".slug" do
  	  let!(:slug) { @post.slug }

  	  it "has a slug of the title" do
  	  	slug.should_not == nil
  	  end
  	end

  	describe ".keywords" do
  	  let!(:keywords) { @post.keywords }

  	  it "returns the topic of the post" do
  	  	keywords[:topic].should == "Dummy"
  	  end

  	  it "returns the tags of the post" do
  	  	keywords[:tags].should == ['lorem', 'indonesia']
  	  end  	  
  	end
  end

  describe "scoping posts" do
    let!(:post_1) { FactoryGirl.create(:post, :dummy_keywords, user: user) }
    let!(:post_2) { FactoryGirl.create(:post, :draft, user: user) }
    let!(:post_3) { FactoryGirl.create(:post_with_user, :draft, :dummy_keywords) }

	describe "Post.published" do
	  let!(:result) { Post.published }

	  it "returns post that has draft attribute set to false" do
	  	result.count.should == 1
	  end
	end

	describe "Post.draft" do
	  let!(:result) { Post.drafted }

	  it "returns post that has draft attribute set to true" do
	  	result.count.should == 2
	  end
	end	

	describe "Post.subject" do
	  let!(:result) { Post.subject('test dummy') }

	  it "returns post that has 'test dummy' as its topic" do
	  	result.count.should == 2
	  end
	end	
  end


end