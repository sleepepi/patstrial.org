Rails.application.routes.draw do
  namespace :admin do
    root to: 'admin#index'
    resources :users
  end

  scope module: 'admin' do
    resources :viewers
  end

  scope module: 'application' do
    get :credits
    get :theme
    get :version
    get :welcome
    get :window
  end

  scope module: 'editor' do
    get 'editor' => 'editor#index'
    resources :categories do
      resources :documents do
        collection do
          post :upload, action: :create_multiple
        end
      end
    end
    resources :members
  end

  scope module: 'internal' do
    get :dashboard
    get :directory
    get 'documents/:category', action: :category, as: :internal_category
    get 'documents/:category/:document_id', action: :document, as: :internal_category_document
  end

  devise_for :users, controllers: { sessions: 'sessions' },
                     path_names:  { sign_up: 'join',
                                    sign_in: 'login',
                                    sign_out: 'logout' },
                     path: ''

  root to: 'application#welcome'
end
