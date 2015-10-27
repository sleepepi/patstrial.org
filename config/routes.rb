Rails.application.routes.draw do
  get 'setup/index'

  get 'external/sites'

  namespace :admin do
    resources :users
    resources :viewers
  end

  scope module: 'admin' do
    get 'admin' => 'admin#index'
  end

  scope module: 'application' do
    get :credits
    get :theme
    get :version
    get :window
  end

  namespace :editor do
    resources :categories do
      resources :documents do
        collection do
          post :upload, action: :create_multiple
        end
      end
    end
    resources :committees do
      resources :committee_members, path: 'members'
    end
    resources :members
    resources :sites
  end

  scope module: 'editor' do
    get 'editor' => 'editor#index'
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
    get :home
    get :participate
    get :sites
  end

  scope module: :setup do
    get 'setup' => 'setup#index'
  end

  devise_for :users, controllers: { sessions: 'sessions' },
                     path_names:  { sign_up: 'join',
                                    sign_in: 'login',
                                    sign_out: 'logout' },
                     path: ''

  root to: 'external#home'
end
