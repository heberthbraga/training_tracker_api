Apipie.configure do |config|
  config.app_name                 = "TrainingTrackerApi"
  config.api_base_url             = ""
  config.doc_base_url             = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher  = "#{Rails.root}/app/controllers/**/*.rb"
  config.translate                = false
  config.default_locale           = nil
  config.validate                 = false
end
