# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :consents
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
