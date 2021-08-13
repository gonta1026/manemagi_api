Rails.application.routes.draw do
  scope :api do
    root to: 'home#index'
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'auth/registrations'
  }

    resources :shops, only: [:index, :create]
    resources :shoppings, only: [:index, :create, :destroy, :show, :edit, :update]
    resources :settings, only: [:index, :create, :update]
    resources :claims, only: [:index, :create, :new, :update, :destroy] do
      member do
        get :shoppings
      end
    end
  end
end
