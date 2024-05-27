# frozen_string_literal: true

namespace :coco_auth do
  desc 'Load database configurations for coco_auth engine'
  task :load_config do
    CocoAuth.with_engine_connection do
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
      ActiveRecord::Base.establish_connection(:coco_auth)
    end
  end

  desc 'Run migrations for coco_auth engine'
  task migrate: :load_config do
    CocoAuth.with_engine_connection do
      engine_root = File.expand_path('../..', __dir__)
      migration_paths = [File.join(engine_root, 'db', 'migrate')]
      migration_context = ActiveRecord::MigrationContext.new(migration_paths, ActiveRecord::SchemaMigration)
      migration_context.migrate
    end
  end

  desc 'Create database for coco_auth engine'
  task create_db: :load_config do
    CocoAuth.with_engine_connection do
      ActiveRecord::Tasks::DatabaseTasks.create_current
    end
  end

  desc 'Drop database for coco_auth engine'
  task drop_db: :load_config do
    CocoAuth.with_engine_connection do
      ActiveRecord::Tasks::DatabaseTasks.drop_current
    end
  end

  desc 'Prepare database for coco_auth engine'
  task prepare: %i[create_db migrate]
end
