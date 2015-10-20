Rails.application.routes.draw do
  namespace :admin do
    root to: 'admin#index'
    resources :users
  end

  scope module: 'application' do
    get :credits
    get :theme
    get :version
    get :welcome
    get :window
  end

  scope module: 'internal' do
    get :dashboard
    get :directory
  end

  resources :members

  devise_for :users, path_names: { sign_up: 'join',
                                   sign_in: 'login',
                                   sign_out: 'logout' },
                     path: ''

  root to: 'application#welcome'
end
