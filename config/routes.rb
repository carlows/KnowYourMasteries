Rails.application.routes.draw do
  resources :summoners, only: [:index, :show, :update, :create]
  resource :stats, only: :show

  get 'search/', to: 'summoners#search', as: 'search'

  root 'summoners#search'
end
