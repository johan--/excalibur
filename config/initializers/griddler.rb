Griddler.configure do |config|
  config.processor_class = EmailProcessor
  config.processor_method = :process
  config.reply_delimiter = '--TULIS BALASAN DI ATAS GARIS INI--'
  config.email_service = :mandrill
end