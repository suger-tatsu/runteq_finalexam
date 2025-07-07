Rails.application.routes.draw do
  get "static/terms"
  get "static/privacy"
  get "static/guide"
  root "home#index"

  get    "login",    to: "sessions#new",     as: :login
  post   "login",    to: "sessions#create"
  delete "logout",   to: "sessions#destroy", as: :logout

  get "teachers/edit_password", to: "teachers#edit_password", as: :edit_teacher_password
  patch "teachers/update_password", to: "teachers#update_password", as: :update_teacher_password

  get "teachers/edit_icon", to: "teachers#edit_icon", as: :edit_teacher_icon
  patch "teachers/update_icon", to: "teachers#update_icon", as: :update_teacher_icon
  get  "register", to: "teachers#new",    as: :register
  post "teachers", to: "teachers#create"

  resources :students do
    collection do
      get :autocomplete
    end
  end

  resources :skills do
    collection do
      get :autocomplete
    end
  end

  resources :group_assignments do
    collection do
      get :autocomplete
    end

    member do
      get :edit_groups
      patch :update_groups
      get :share_settings
      patch :update_sharing
      patch :toggle_sharing
    end
  end

    namespace :public do
      get "group_assignments/:token", to: "group_assignments#show", as: "group_assignment"
      get "group_assignments/:token/password", to: "group_assignments#password", as: "password_group_assignment"
      post "group_assignments/:token/verify_password", to: "group_assignments#verify_password", as: "verify_password_group_assignment"
   end

  get "up" => "rails/health#show", as: :rails_health_check

  get "/auth/:provider/callback", to: "sessions#omniauth"
  get "/auth/failure", to: redirect("/")
  get "/auth_test", to: redirect("/auth/google_oauth2")
end
