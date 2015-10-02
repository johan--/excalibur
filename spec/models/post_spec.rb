require 'rails_helper'

RSpec.describe Post, :type => :model do
  let!(:user) { FactoryGirl.create(:admin) }

  before(:each) do
  	@post = Post.new(title: "Test Post Numero Uno", draft: true, user: user,
  		content_md: "Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor",
  		topic: "Dummy", tags_text: "lorem, indonesia")
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
  	  	expect(slug).to_not eq nil
  	  end
  	end

  	describe ".keywords" do
  	  it "returns the topic of the post" do
        expect(@post.topic).to eq "Dummy"
  	  end

  	  it "returns the tags of the post" do
        expect(@post.tags).to eq ["lorem", "indonesia"]
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
  	  	expect(result.count).to eq 1
  	  end
  	end

  	describe "Post.draft" do
  	  let!(:result) { Post.drafted }

  	  it "returns post that has draft attribute set to true" do
  	  	expect(result.count).to eq 2
  	  end
  	end	

  	describe "Post.by_topic" do
  	  let!(:result) { Post.by_topic('test dummy') }

  	  it "returns post that has 'test dummy' as its topic" do
  	  	expect(result.count).to eq 3
  	  end
  	end

    describe "Post.by_tag" do
      let!(:result) { Post.by_tag('lorem') }

      it "returns post that has 'test dummy' as its topic" do
        expect(result.count).to eq 3
      end
    end     	
  end


end