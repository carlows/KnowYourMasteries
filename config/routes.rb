Rails.application.routes.draw do
  root 'team#show'

  resource :team, only: [:show, :new, :create, :edit, :update]
end
