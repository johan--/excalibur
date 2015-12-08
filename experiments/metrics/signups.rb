metric "Signups (Unlimited)" do
  description "Signups to our All You Can Eat and Burp Unlimited plan (including upgrades)."
  User.after_save do |account|
    track! if account.client? || account.financier?
  end
end