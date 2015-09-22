class Document < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  
  attr_accessor :image_id
  store_accessor :details, 
  					:public_id, :bytes
  has_attachments  :proofs, accept: [:jpg, :png, :pdf]
end