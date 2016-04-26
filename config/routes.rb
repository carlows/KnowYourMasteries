Rails.application.routes.draw do
  resources :summoners, only: [:index, :show, :update, :create]
  resource :stats, only: :show

  get 'search/', to: 'summoners#search', as: 'search'
  get 'not_found', to: 'summoners#not_found', as: 'summoner_not_found'
  get 'apierror', to: 'summoners#apierror', as: 'apierror'

  root 'summoners#search'
end
