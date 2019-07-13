CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['aws_access_key_id'],
    aws_secret_access_key: ENV['aws_secret_access_key'],
    region: ENV['region'],
    :path_style            => true
  }

  config.cache_storage = :fog
  config.fog_public = false
  config.fog_authenticated_url_expiration = 60
  config.cache_dir = 'tmp/image-cache'
  config.fog_directory = ENV['config.fog_directory']
  config.asset_host = ENV['config.asset_host']
end