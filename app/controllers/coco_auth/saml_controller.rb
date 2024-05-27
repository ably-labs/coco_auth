# frozen_string_literal: true

module CocoAuth
  class SamlController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:acs]

    def auth
      settings = SamlSettings.get_saml_settings
      request = OneLogin::RubySaml::Authrequest.new
      redirect_to(request.create(settings))
    end

    def acs
      settings = SamlSettings.get_saml_settings
      response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], settings:)

      if response.is_valid?
        user = User.find_by(email: response.name_id)
        sign_in(user)
        redirect_to main_app.root_url
      else
        render plain: 'Invalid SAML Response'
      end
    end
  end
end
