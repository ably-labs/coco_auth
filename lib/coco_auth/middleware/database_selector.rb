# frozen_string_literal: true

module CocoAuth
  module Middleware
    class DatabaseSelector
      def initialize(app)
        @app = app
      end

      def call(env)
        if env['PATH_INFO'].start_with?('/__coco_auth__')
          CocoAuth.with_engine_connection { @app.call(env) }
        else
          @app.call(env)
        end
      end
    end
  end
end
