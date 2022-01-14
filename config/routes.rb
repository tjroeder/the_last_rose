Rails.application.routes.draw do
  resources :bachelorettes, only: [:show], as: 'bach' do
    resources :contestants, only: [:index], as: 'cont', controller: 'bachelorette_contestants'
  end
  
  resources :contestants, only: [:show]
  resources :outings, only: [:show]
end
