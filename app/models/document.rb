class Document < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :owner, polymorphic: true
  
  attr_accessor :image_id
  store_accessor :details, 
  					:public_id, :bytes, :current_state, :previous_state


  def slug_candidates
    [ 
      :name,
      [:name, :owner_id]
    ]
  end
end