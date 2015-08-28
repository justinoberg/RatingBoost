

CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'AKIAJ4UJAF2AEJ6CF2QA',                        # required
    aws_secret_access_key: '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',                        # required
  }
  config.fog_directory  = 'ratingboost'                          # required
end

