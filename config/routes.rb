Rails.application.routes.draw do
  get "students/index"
  get "sessions/new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root 'home#index'
  
  # ログイン画面
  get 'login', to: 'sessions#new', as: :login
  
  # ログイン処理
  post 'login', to: 'sessions#create'
  
  # 生徒一覧ページ
  get 'students', to: 'students#index', as: :students

  get 'new_students', to: 'students#new',as: :new_students

  post 'students', to: 'students#create'
  
  # 新規登録画面
  get 'register', to: 'teachers#new', as: :register
  
  # 新規登録処理
  post 'teachers', to: 'teachers#create'
  
  # ログアウト
  delete 'logout', to: 'sessions#destroy', as: :logout

  # resources :students
end
