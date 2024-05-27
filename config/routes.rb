# frozen_string_literal: true

CocoAuth::Engine.routes.draw do
  namespace :admin do
    resources :users
    resources :apps
  end
end
