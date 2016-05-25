class Comment < ActiveRecord::Base
  include WannabeBool::Attributes

  acts_as_nested_set :scope => [:commentable_id, :commentable_type]

  # validates :subject, :presence => true
  validates :user, :presence => true

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  # acts_as_votable

  belongs_to :commentable, :polymorphic => true
  belongs_to :user # NOTE: Comments belong to a user

  delegate :name, to: :user, prefix: true
  delegate :avatar, to: :user, prefix: true

  store_accessor :details, 
                 :official, :flagged
  attr_wannabe_bool :official, :flagged
  
  # Markdown
  # before_save :mark_it_down!

  scope :assessments, -> { where(subject: 'assessment') } 
  scope :user_as_subject, ->(user) { where(commentable: user) } 

  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  def self.build_from(obj, user_id, comment)
    new \
      :commentable => obj,
      :body_html        => comment,
      :user_id     => user_id
  end

  #helper method to check if a comment has children
  def has_children?
    self.children.any?
  end

  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  scope :find_comments_by_user, lambda { |user|
    where(:user_id => user.id).order('created_at DESC')
  }

  # Helper class method to look up all comments for
  # commentable class name and commentable id.
  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')
  }

  # Helper class method to look up a commentable object
  # given the commentable class name and id
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end

  def author?(user)
    if self.user == user
      return true
    else
      return false
    end
  end


private
  def mark_it_down!
    MarkdownWriter.html_comment(self)
  end

end