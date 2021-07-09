Rails.application.routes.draw do
  scope :api do
    root to: 'home#index'
    mount_devise_token_auth_for 'User', at: 'auth'
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :shops, only: [:index, :create]
    resources :shoppings, only: [:index, :create, :show]
    resources :claims, only: [:index, :create]
    resources :settings, only: [:index, :create]
  end
end
