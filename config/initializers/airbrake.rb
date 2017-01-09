if Rails.env.production?
  Airbrake.configure do |config|
    config.host = 'http://rose-triangle.com:8081'
    config.project_id = 1
    config.project_key = AppConfig.airbrake.project_key

    config.environment = Rails.env
  end

  Sidekiq.configure_server do |config|
    config.error_handlers << Proc.new {|ex,ctx_hash| Airbrake.notify(ex, ctx_hash) }
  end
end
