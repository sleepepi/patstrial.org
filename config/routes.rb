Rails.application.routes.draw do
  get 'external/sites'

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

  namespace :editor do
    resources :committees do
      resources :committee_members, path: 'members'
    end
    resources :sites
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

  scope module: 'committees' do
    get 'committees', action: :index, as: :committees
    get 'committees/:committee', action: :show, as: :committee
  end

  scope module: 'internal' do
    get :dashboard
    get :directory
    get 'documents/:category', action: :category, as: :internal_category
    get 'documents/:category/:document_id', action: :document, as: :internal_category_document
  end

  scope module: 'external' do
    get :contact
    get :sites
  end

  devise_for :users, controllers: { sessions: 'sessions' },
                     path_names:  { sign_up: 'join',
                                    sign_in: 'login',
                                    sign_out: 'logout' },
                     path: ''

  root to: 'application#welcome'
end
