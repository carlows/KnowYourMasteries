Rails.application.routes.draw do
  devise_for :users

  root 'team#index'

  resource :team, only: [:show, :new, :create, :edit, :update]
end
