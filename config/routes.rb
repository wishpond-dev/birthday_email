# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :consents
  resources :users
  resources :campaigns
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
