class Like < Socialization::ActiveRecordStores::Like
  # acts_as_commentable
  # has_one :comment, as: :commentable

  # after_destroy :delete_comment
  # cattr_accessor :vouchers do
  #   ["keluarga", "sahabat", "kolega"]
  # end

  


private

  # def delete_comment
  # 	Comment.where(commentable_type: 'Like', commentable_id: id).first.delete
  # end

end