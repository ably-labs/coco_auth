# frozen_string_literal: true

require 'coco_auth/version'
require 'coco_auth/engine'
require 'coco_auth/middleware/database_selector'

module CocoAuth
  def self.with_engine_connection
    engine_root = File.expand_path('..', __dir__)
    config_file = File.join(engine_root, 'config', 'coco_auth_database.yml')
    database_config = YAML.safe_load(ERB.new(File.read(config_file)).result, aliases: true)

    ActiveRecord::Base.configurations = ActiveRecord::DatabaseConfigurations.new(
      ActiveRecord::Base.configurations.configurations + [
        ActiveRecord::DatabaseConfigurations::HashConfig.new(
          Rails.env, 'coco_auth', database_config[Rails.env]
        )
      ]
    )

    original_config = ActiveRecord::Base.remove_connection
    ActiveRecord::Base.establish_connection(:coco_auth)
    yield
  ensure
    ActiveRecord::Base.establish_connection(original_config)
  end
end
