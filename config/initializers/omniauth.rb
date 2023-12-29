require 'open-uri'

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '376842932745-snntihsnthhvp0f04utcq669t2rvu4r0.apps.googleusercontent.com', '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'
end