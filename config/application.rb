require File.expand_path('../boot', __FILE__)

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InvoiceTracker
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec, fixtures: true,
                               view_specs: false,
                               helper_specs: false,
                               routing_specs: false,
                               controller_specs: false,
                               request_specs: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.assets.precompile += %w(upmin/upmin.css number_pages pdf.css)
    config.eager_load_paths += %W(#{config.root}/app/state_machines)

    # Skip before_filter for devise sessions controller
    config.to_prepare do
      Devise::SessionsController.skip_before_filter :authenticate_user!
    end

    # Use Bower packages in assets pipeline
    config.assets.paths << \
      Rails.root.join('vendor', 'assets', 'bower_components')
    config.assets.paths << \
      Rails.root.join('vendor', 'assets', 'bower_components', \
                      'bootstrap-sass-official', 'assets', 'fonts')

    config.assets.precompile << /.*.(?:eot|svg|ttf|woff)$/

    # Angular templates
    config.angular_templates.markups.push 'slim'

    config.assets.precompile += ['*.slim', '*/*.slim']

    config.assets.js_compressor = Uglifier.new(mangle: false)

    config.to_prepare do
      DeviseController.respond_to :html, :json
    end
  end
end
