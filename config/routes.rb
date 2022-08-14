Rails.application.routes.draw do
  root 'ceaps#index'
  get 'expenses' => 'expenses#index'
  get 'expenses/show' => 'expenses#show'
  resources :ceaps
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
