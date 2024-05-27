# frozen_string_literal: true

require_dependency 'coco_auth/application_controller'

module CocoAuth
  module Admin
    class UsersController < ApplicationController
      def index
        @users = User.all
      end

      def new
        @user = User.new
      end

      def create
        @user = User.new(user_params)
        if @user.save
          redirect_to admin_users_path
        else
          render :new
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
      end
    end
  end
end
