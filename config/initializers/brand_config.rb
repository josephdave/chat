module BrandConfig
  def self.brand_name
    Rails.env.test? ? 'Chatwoot' : (ENV.fetch('BRAND_NAME', 'Chatwoot'))
  end

  def self.logo_url
    ENV.fetch('BRAND_LOGO_URL', nil)
  end

  def self.favicon_url
    ENV.fetch('BRAND_FAVICON_URL', nil)
  end

  def self.primary_color
    ENV.fetch('BRAND_PRIMARY_COLOR', '#1f93ff')
  end

  def self.secondary_color
    ENV.fetch('BRAND_SECONDARY_COLOR', '#f0f0f0')
  end

  def self.mailer_sender_name
    brand_name
  end

  def self.default_logo_url
    'logo.svg'
  end

  def self.default_favicon_url
    'favicon.png'
  end

  def self.hide_upgrade_options?
    ENV.fetch('HIDE_UPGRADE_OPTIONS', 'true').downcase == 'true'
  end
end