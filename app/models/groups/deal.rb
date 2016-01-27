class Deal < Group
  groupify :group, members: [:tenders, :bids], default_members: :tenders
  protokoll :name, :pattern => "Deal#m####"

  store_accessor :details, 
                 :public, :purpose
end