Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'posts#index'
  get 'toggle_like', to: 'posts#toggle_like'
  get 'toggle_follow', to: 'posts#toggle_follow'

  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
