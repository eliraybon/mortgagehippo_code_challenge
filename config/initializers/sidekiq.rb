# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://coin-machine-api.herokuapp.com', namespace: "coin_machine_#{Rails.env}" }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://coin-machine-api.herokuapp.com', namespace: "coin_machine_#{Rails.env}" }
# end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://coin-machine-api.herokuapp.com:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://coin-machine-api.herokuapp.com:6379' }
end

