# frozen_string_literal: true

module CocoAuth
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'tasks/coco_auth_tasks.rake'
    end
  end
end
