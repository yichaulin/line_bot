Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/callbacks' => 'line_bots#callbacks'
  resources :stores

  root :to => 'line_bots#index'
end
