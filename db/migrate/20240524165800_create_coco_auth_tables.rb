# frozen_string_literal: true

class CreateCocoAuthTables < ActiveRecord::Migration[6.1]
  def change
    create_table :coco_auth_users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :first_name
      t.string :last_name
      t.timestamps
    end

    create_table :coco_auth_apps do |t|
      t.string :name, null: false
      t.string :description
      t.string :entity_id, null: false, index: { unique: true }
      t.string :assertion_consumer_service_url, null: false
      t.string :sso_url, null: false
      t.string :slo_url
      t.text :certificate, null: false

      t.timestamps
    end
  end
end
