OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '815397731829535', '580a9dd6f29085d61a2fd5fe2d3a1724'
end