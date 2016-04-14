class Identity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.create_with_omniauth(auth)
    Identity.create do |identity|
      identity.provider     = auth.provider
      identity.uid          = auth.uid
      identity.token        = auth.credentials.token
      identity.secret       = auth.credentials.secret if auth.credentials.secret
      identity.expires_at   = auth.credentials.expires_at if auth.credentials.expires_at
      identity.email        = auth.info.email if auth.info.email
      identity.location     = auth.info.location if auth.info.location
      # if auth.provider == 'facebook'
      #   identity.public_url = auth.info.urls[:Facebook]
      # else
      #   identity.public_url = auth.info.urls[:public_profile]
      # end
    end
  end

  def self.update_user_missing_info(current_user)
    self.user = current_user
    self.user.email       ||= self.email
    self.user.avatar       ||= self.image
    self.user.first_name  ||= self.first_name
    self.user.last_name   ||= self.last_name
    self.user.name = "#{self.first_name} #{self.last_name}"
    self.user.location   ||= self.location
    self.user.understanding = 'yes'
    self.user.auth_with    = self.provider
    self.user.skip_reconfirmation!
    self.user.save!
  end

  # def find_or_create_user(current_user)
  #   if current_user && self.user == current_user
  #     # User logged in and the identity is associated with the current user
  #     return self.user
  #   elsif current_user && self.user != current_user
  #     # User logged in and the identity is not associated with the current user
  #     # so lets associate the identity and update missing info
  #     self.update_user_missing_info(current_user)
  #     self.save!
  #     return self.user
  #   elsif self.user.present?
  #     # User not logged in and we found the identity associated with user
  #     # so let's just log them in here
  #     return self.user
  #   else
  #     # No user associated with the identity so we need to create a new one
  #     self.build_user(
  #       email: self.email,
  #       password: Devise.friendly_token[0,20],
  #       avatar: self.image,
  #       name: "#{self.first_name} #{self.last_name}",
  #       first_name: self.first_name,
  #       last_name: self.last_name,
  #     	location: self.location,
  #     	understanding: 'yes',
  #     	auth_with: self.provider        
  #     )
  #     self.user.save!(validate: false)
  #     self.save!

  #     return self.user
  #   end
  # end

end