class Post < ActiveRecord::Base
  # Use friendly_id
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_attachment  :header
  # Markdown
  before_save { MarkdownWriter.update_html(self) }

  # Validations
  validates :title, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :content_md, presence: true

  # Pagination
  paginates_per 7

  # Relations
  belongs_to :user

  serialize :keywords, HashSerializer
  store_accessor :keywords, :topic, :tags

  # Scopes
  default_scope { order(created_at: :desc) }
  scope :published, lambda {
    where(draft: false)
    .order("updated_at DESC")
  }

  scope :drafted, lambda {
    where(draft: true)
    .order("updated_at DESC")
  }
  scope :recent, -> { order('created_at DESC').limit(5) }
  scope :by_topic, ->(subject) { 
    where("posts.keywords->>'topic' = :words", words: "#{subject}") 
  }
  scope :by_tag, ->(words) { 
    #Not working, presummably because of the function
    # where("posts.keywords->>'tags' = :words", words: "#{words}") 

    # These one works
    where("keywords -> 'tags' ? :word", word: words)
    # where("keywords -> 'tags' ? :word", word: "#{words}")
  }  


end
