# frozen_string_literal: true

Rails.application.routes.draw do
  root 'external#home'

  namespace :admin do
    resources :users
    resources :viewers
  end

  scope module: 'admin' do
    get 'admin' => 'admin#index'
  end

  scope module: 'application' do
    get :credits
    get :version
  end

  namespace :calculators do
    get :bmi_zscore, path: 'bmi-zscore'
    post :bmi_zscore, path: 'bmi-zscore', action: :bmi_zscore_calculate, as: :bmi_zscore_calculate
    get :bmi_zscore_result, path: 'bmi-zscore/result'
    get :blood_pressure_percentile, path: 'blood-pressure-percentile'
    post :blood_pressure_percentile, path: 'blood-pressure-percentile',
                                     action: :blood_pressure_percentile_calculate,
                                     as: :blood_pressure_percentile_calculate
    get :blood_pressure_percentile_result, path: 'blood-pressure-percentile/result'
    get '/', action: :index
    get '/(*path)', to: redirect('calculators')
  end

  resources :drugs

  namespace :editor do
    resources :categories, path: 'folders' do
      resources :documents do
        collection do
          post :upload, action: :create_multiple
        end
      end
      resources :videos
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

  scope module: 'external' do
    get :contact
    get :home
    get :participate
    get :sites
  end

  namespace :reports do
    root to: redirect('dashboard')
    get :screened
    get :consented
    get :eligible
    get :randomized
    get :demographics
    get 'demographics/:subjects', action: :demographics, as: :demographics_status
    get :eligibility_status, path: 'eligibility-status'
    get :eligibility_status_consented, path: 'eligibility-status/consented'
  end

  scope module: :setup do
    get 'setup' => 'setup#index'
  end

  devise_for :users, controllers: { sessions: 'sessions' },
                     path_names:  { sign_up: 'join',
                                    sign_in: 'login',
                                    sign_out: 'logout' },
                     path: ''

  # Needs to stay near bottom in order to handle "top_level" catch all.
  scope module: 'internal' do
    get :dashboard
    get :directory
    get ':top_level/:category', action: :category, as: :internal_category
    get ':top_level/:category/documents/:document_id', action: :document, as: :internal_category_document
    get ':top_level/:category/videos/:video_id', action: :video, as: :internal_category_video
  end
end
