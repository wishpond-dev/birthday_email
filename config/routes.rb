# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  resources :consents
  resources :users

  # Use this code just for developement, in production need to add a authenticated route to it
  # mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
