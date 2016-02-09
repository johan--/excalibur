global_events_prefix :ab

version 1, "2016-02-09" do
  category :user do
    event :subscribed, "2016-02-09", "user subscribed"
    event :signed_up, "2016-02-09", "user signed up"
    event :open_simulation, "2016-02-09", "user opened simulation"
    event :simulate, "2016-02-09", "user run the simulation"
  end
  category :visit do
  	event :blog, "2016-02-09", "someone visited the blog"
  	event :blogpost, "2016-02-09", "someone view a blogpost"
  	event :landing, "2016-02-09", "someone landed on Kapiten"
  end
end