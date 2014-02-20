DbcRspecRails::Application.routes.draw do
  namespace :admin do
    resources :posts
  end
  resources :admin
  resources :posts

  root :to => "home#index"
end