class Syndicate < Group
  protokoll :name, :pattern => "Syndicate#y####"
  has_members :users
  
  store_accessor :details, 
                 :public, :aqad

 
end