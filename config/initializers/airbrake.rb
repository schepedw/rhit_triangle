if Rails.env.production?
  Airbrake.configure do |config|
    config.host = 'http://rose-triangle.com:8081'
    config.project_id = 1
    config.project_key = AppConfig.airbrake.project_key

    config.environment = Rails.env
  end
end
