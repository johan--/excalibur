metric "Signups (Unlimited)" do
  description "Signups to our All You Can Eat and Burp Unlimited plan (including upgrades)."
  User.after_create do |user|
    track!
  end
end