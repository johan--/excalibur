metric "Signups (Unlimited)" do
  description "Signups to our All You Can Eat and Burp Unlimited plan (including upgrades)."
  User.after_create do |user|
    track!
  end
  complete_if do
    alternatives.all? { |alt| alt.participants >= 100 } ||
      (score.choice && score.choice.probability >= 95)
  end  
end