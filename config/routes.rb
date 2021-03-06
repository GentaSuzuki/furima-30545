Rails.application.routes.draw do
  get 'orders/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "items#index"
  get 'items/seach'
   resources :items do
    collection do
      get 'search'
    end
    resources :orders, only: [:index,:create]
   end
end
