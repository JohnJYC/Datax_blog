Rails.application.routes.draw do
  resources :users
  resources :articles
  resources :tags
  resources :categories
  get "tags/index"
  get "tags/show"
  get "tags/new"
  get "tags/edit"
  get "tags/create"
  get "tags/update"
  get "tags/destroy"
  post '/login', to: 'sessions#create'  # 指定 POST 请求指向 SessionsController 的 create 方法
  get "categories/index"
  get "categories/show"
  get "categories/new"
  get "categories/edit"
  get "categories/create"
  get "categories/update"
  get "categories/destroy"
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "users/new"
  get "users/create"
  get "users/show"
  get "users/edit"
  get "users/update"
  get "users/destroy"
  get "articles/index"
  get "articles/show"
  get "articles/new"
  get "articles/edit"
  get "articles/create"
  get "articles/update"
  get "articles/destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
