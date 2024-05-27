# frozen_string_literal: true

require_dependency 'coco_auth/application_controller'

module CocoAuth
  module Admin
    class AppsController < ApplicationController
      def index
        @apps = App.all
      end

      def new
        @app = App.new
      end

      def create
        @app = App.new(app_params)
        if @app.save
          redirect_to admin_apps_path
        else
          render :new
        end
      end

      private

      def app_params
        params.require(:app).permit(:name, :description, :entity_id, :assertion_consumer_service_url, :sso_url,
                                    :slo_url, :certificate)
      end
    end
  end
end
