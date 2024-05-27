# frozen_string_literal: true

require 'rails'
require 'active_record'

module CocoAuth
  class Engine < ::Rails::Engine
    isolate_namespace CocoAuth

    config.autoload_paths << File.expand_path('../lib/coco_auth/middleware', __dir__)

    allowed_tasks = ['coco_auth:create_db', 'coco_auth:migrate', 'coco_auth:prepare', 'coco_auth:drop_db']
    allowed_tasks_regex = Regexp.union(allowed_tasks)

    initializer 'coco_auth.load_database_config', before: :load_config_initializers do
      ActiveSupport.on_load(:active_record) do
        engine_root = File.expand_path('../..', __dir__)
        config_file = File.join(engine_root, 'config', 'coco_auth_database.yml')
        database_config = YAML.safe_load(ERB.new(File.read(config_file)).result, aliases: true)

        ActiveRecord::Base.configurations = ActiveRecord::DatabaseConfigurations.new(
          ActiveRecord::Base.configurations.configurations + [
            ActiveRecord::DatabaseConfigurations::HashConfig.new(
              Rails.env, 'coco_auth', database_config[Rails.env]
            )
          ]
        )
      end
    end

    initializer 'coco_auth.setup_db' do
      ActiveSupport.on_load(:active_record) do
        if defined?(Rake) && Rake.application.top_level_tasks.grep(allowed_tasks_regex).any?
          ActiveRecord::Base.establish_connection(:coco_auth)
        end
      end
    end

    initializer 'coco_auth.middleware' do |app|
      app.middleware.use ::CocoAuth::Middleware::DatabaseSelector
    end

    initializer 'coco_auth.assets.precompile' do |app|
      app.config.assets.precompile += %w[coco_auth/application.css coco_auth/application.js]
    end

    config.generators do |g|
      g.orm :active_record, migration: false
    end
  end
end
