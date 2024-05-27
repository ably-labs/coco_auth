# frozen_string_literal: true

module CocoAuth
  class App < ApplicationRecord
    validates :name, presence: true
    validates :entity_id, presence: true, uniqueness: true
    validates :assertion_consumer_service_url, presence: true
    validates :sso_url, presence: true
    validates :certificate, presence: true
  end
end
