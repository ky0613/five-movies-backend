require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_directory  = 'five-movies' # バケット名
  config.fog_public = false
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: Rails.application.credentials.aws[:access_key_id], # アクセスキー
    aws_secret_access_key:  Rails.application.credentials.aws[:secret_access_key], # シークレットアクセスキー
    region: 'ap-northeast-1', # リージョン
    path_style: true
  }
end
