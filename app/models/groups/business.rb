class Business < Group
  has_members :users
  protokoll :name, :pattern => "Biz#m####"

  store_accessor :details, 
                 :formal, :special
end