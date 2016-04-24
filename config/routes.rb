Rails.application.routes.draw do
  resources :summoners, only: [:index, :show, :update, :create]
  resource :stats, only: :show

  get 'search/:query', to: 'summoner#search', as: 'search'

  root 'summoner#search'
end
