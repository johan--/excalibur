# module OmniauthMacros
  def mock_auth_hash_facebook
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      'provider' => 'facebook',
      'uid' => '123545',
      'info' => {
        'email' => 'facebooker@example.com',
        'image' => '//res.cloudinary.com/instilla/image/upload/s--iftDNybA--/c_scale,h_300,w_450/v1452508512/asset/2000px-House_Silhouette.png',
        'first_name' => 'facebook',
        'last_name' => 'user',
        'location' => 'jakarta',
        'urls' => {
          'Facebook' => 'facebook.com/facebooker'
        }
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    })
  end

  def mock_auth_hash_google
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      'provider' => 'google_oauth2',
      'uid' => '123545',
      'info' => {
        'email' => 'googler@example.com',
        'name' => 'googler'
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    })
  end

  def mock_auth_hash_link
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
      'provider' => 'linkedin',
      'uid' => '123545',
      'info' => {
        'email' => 'link@example.com',
        'image' => '//res.cloudinary.com/instilla/image/upload/s--iftDNybA--/c_scale,h_300,w_450/v1452508512/asset/2000px-House_Silhouette.png',
        'first_name' => 'link',
        'last_name' => 'user',
        'location' => 'jakarta',        
        'urls' => {
          'public_profile' => 'linkedin.com/link'
        }
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    })
  end  
# end