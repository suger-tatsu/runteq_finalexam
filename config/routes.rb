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

  get 'students/:id', to: 'students#show', as: :student
  # 生徒編集ページ
  get 'students/:id/edit', to: 'students#edit', as: :edit_student
  
  # 生徒情報の更新
  patch 'students/:id', to: 'students#update'
  
  # 生徒削除
  delete 'students/:id', to: 'students#destroy'

  get 'skills', to: 'skills#index', as: :skills

  get 'new_skill', to: 'skills#new', as: :new_skill

  post 'skills', to: 'skills#create'

  get 'skills/:id', to: 'skills#show', as: :skill

  get 'skills/:id/edit', to: 'skills#edit', as: :edit_skill
  
  patch 'skills/:id', to: 'skills#update'
  
  delete 'skills/:id', to: 'skills#destroy'

  delete 'group_assignments/:id', to: 'group_assignments#destroy'

  get 'group_assignments', to: 'group_assignments#index', as: :group_assignments

  get 'new_group_assignment', to: 'group_assignments#new', as: :new_group_assignment

  post 'group_assignments', to: 'group_assignments#create'

  get 'group_assignments/:id', to: 'group_assignments#show', as: :group_assignment

  get 'group_assignments/:id/edit', to: 'group_assignments#edit', as: :edit_group_assignment

  patch 'group_assignments/:id', to: 'group_assignments#update'

  
  # 新規登録画面
  get 'register', to: 'teachers#new', as: :register
  
  # 新規登録処理
  post 'teachers', to: 'teachers#create'
  
  # ログアウト
  delete 'logout', to: 'sessions#destroy', as: :logout

  # resources :students
end
