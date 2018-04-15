Rails.application.routes.draw do
  resources :scores
  resources :notes
  root to:  'notes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, format: 'json' do
    resources :notes, only: [:index, :create, :update]
  end


end
