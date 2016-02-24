class WikiPage < ActiveRecord::Base
  acts_as_wiki_page
  extend FriendlyId
  friendly_id :title, use: :slugged

  serialize :details, HashSerializer

  
  before_save :mark_it_down!

  # Pagination
  paginates_per 20

private
  def mark_it_down!
    MarkdownWriter.to_wiki_html(self)
  end

end
