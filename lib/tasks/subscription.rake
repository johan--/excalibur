namespace :subscription do
  desc "Check which active subscriptions are expired"
  task check_expiration: :environment do
  	actives = Subscription.active
  	expires = Subscription.expired
  	puts "Aktif: #{actives.count} | Kadaluwarsa: #{expires.count}"
  	actives.each do |sub|
  		if sub.expired?
  			sub.toggle_expiration!
  		end
  	end
  	puts "Aktif: #{actives.count} | Kadaluwarsa: #{expires.count}"
  end

end
