global_events_prefix :ab

version 1, "2016-02-09" do
  category :user do
    event :subscribed, "2016-02-09", "user subscribed"
    event :signed_up, "2016-02-09", "user signed up"
    event :logged_in, "2016-05-23", "user logged in"
    event :open_simulation, "2016-02-09", "user opened simulation"
    event :simulate, "2016-02-09", "user run the simulation"
    event :download, "2016-02-09", "user download a file"
    event :completed_house, "2016-05-23", "user completed house registration"
    event :created_proposal, "2016-05-23", "user created a proposal"
    event :tabled_bid, "2016-05-23", "user tabled a bid"
    event :modified_bid, "2016-05-23", "user modified a bid"
    event :filling_profile, "2016-05-23", "user filling a profile"
    event :uploaded_document, "2016-05-23", "user uploaded a document"
  end
  category :visit do
  	event :blog, "2016-02-09", "someone visited the blog"
  	event :blogpost, "2016-02-09", "someone view a blogpost"
  	event :landing, "2016-02-09", "someone landed on Kapiten"
    event :proposal, "2016-05-23", "someone visited a proposal page"
    event :house, "2016-05-23", "someone visited a house page"
    event :user, "2016-05-23", "someone visited a user page"
  end
end