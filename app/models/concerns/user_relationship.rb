module UserRelationship
  extend ActiveSupport::Concern
  included do

    has_many :relationships,  foreign_key: "follower_id", 
                              dependent: :destroy

    has_many :friends, through: :relationships, 
                              source: :followed, source_type: 'User'
             
    has_many :reverse_relationships, foreign_key: "followed_id",
                                     class_name: "Relationship",
                                     dependent: :destroy
    has_many :followers,  through: :reverse_relationships,
                          source: :follower
    # relationship methods
      def following?(followed)
        return true if following(followed)
      end

      def following(followed)
        self.relationships.find_by(
          followed_id: followed.id, followed_type: followed.class.name)
      end

      def follow!(followed)
        self.relationships.create!(
          followed_id: followed.id, followed_type: followed.class.name)
      end

      def unfollow!(followed)
        following(followed).destroy
      end  

      # def favorite_venues
      #   self.relationships.venues.map{ |rel| rel.followed }.to_a
      # end
      
  end
end