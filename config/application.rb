require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Congressperson
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.assets.initialize_on_precompile = false
    config.load_defaults 6.1
    config.action_controller.include_all_helpers = false
    config.active_job.queue_adapter = :sidekiq
    config.generators do |g|
      g.template_engine :erb
      g.orm :active_record
      g.test_framework  :test_unit, fixture: true
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
