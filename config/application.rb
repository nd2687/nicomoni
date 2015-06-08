require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nicomoni
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    config.active_record.raise_in_transactional_callbacks = true

    config.generators.fixture_replacement :factory_girl, dir: 'spec/factories'

    config.generators do |g|
      g.assets = false
      g.helper = false
      g.test_framework :rspec, :fixture => false
    end

    config.react.jsx_transform_options = {
      harmony: true,
      strip_types: true
    }
  end
end
