Rails.application.routes.draw do
  scope module: 'application' do
    get :credits
    get :dashboard
    get :theme
    get :version
    get :welcome
    get :window
  end

  devise_for :users, path_names: { sign_up: 'join',
                                   sign_in: 'login',
                                   sign_out: 'logout' },
                     path: ''

  root to: 'application#welcome'
end
