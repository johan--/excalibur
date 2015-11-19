class Naming
  DISQUS_SHORTNAME = Rails.env == "development" ? "instilla".freeze : "sikapiten".freeze
end