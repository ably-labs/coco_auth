# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require 'coco_auth'

module CocoAuth
  class Application < Rails::Application
    config.load_defaults 6.1
  end
end
