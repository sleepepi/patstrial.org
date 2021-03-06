# frozen_string_literal: true

Rails.application.routes.draw do
  root "external#landing"

  namespace :admin do
    resources :users
  end

  scope module: "admin" do
    get "admin" => "admin#index"
  end

  namespace :calculators do
    get :bmi_zscore, path: "bmi-zscore"
    post :bmi_zscore, path: "bmi-zscore", action: :bmi_zscore_calculate, as: :bmi_zscore_calculate
    get :bmi_zscore_result, path: "bmi-zscore/result"
    get "/", to: redirect("calculators/bmi-zscore")
    get "/(*path)", to: redirect("calculators")
  end

  resources :drugs

  get "documents" => "documents#index"

  namespace :editor do
    resources :categories, path: "folders" do
      resources :documents do
        collection do
          post :upload, action: :create_multiple
        end
      end
      resources :videos
    end
    resources :committees do
      resources :committee_members, path: "members"
    end
    resources :members
    resources :sites
  end

  scope module: :editor do
    get "editor" => "editor#index"
  end

  scope module: :committees do
    get "committees", action: :index, as: :committees
    get "committees/:committee", action: :show, as: :committee
  end

  scope module: :external do
    get :contact
    get :landing
    get :participate
    get :sites
    get :credits
    get :privacy_policy, path: "privacy-policy"
    get :version
  end

  resources :pages do
    collection do
      post :add_report, path: "add-report"
    end
  end

  resources :profiles, only: [] do
    member do
      get :picture
    end
  end

  resources :projects

  resources :reports do
    member do
      get :refresh, to: redirect("reports/%{id}")
      post :refresh
    end
  end

  resources :report_rows, only: :new, path: "report-rows"

  namespace :reports_static, path: "report/static" do
    root to: redirect("dashboard")
    get :data_quality, path: "data-quality"
    get :screened
    get :consented
    get :eligible
    get :randomized
    get :demographics
    get "demographics/:subjects", action: :demographics, as: :demographics_status
    get :eligibility_status, path: "eligibility-status"
    get :eligibility_status_screened, path: "eligibility-status/screened"
    get :eligibility_status_consented, path: "eligibility-status/consented"
    get :grades
    get :unscheduled_events, path: "unscheduled-events"
    get :data_inconsistencies, path: "data-inconsistencies"
  end

  get :settings, to: redirect("settings/profile")
  namespace :settings do
    get :profile
    patch :update_profile, path: "profile"
    patch :complete_profile, path: "complete-profile"
    get :profile_picture, path: "profile/picture", to: redirect("settings/profile")
    patch :update_profile_picture, path: "profile/picture"

    get :account
    patch :update_account, path: "account"
    get :password, to: redirect("settings/account")
    patch :update_password, path: "password"
    delete :destroy, path: "account", as: "delete_account"

    get :email
    patch :update_email, path: "email"
  end

  scope module: :setup do
    get "setup" => "setup#index"
  end

  devise_for :users,
             controllers: {
               passwords: "passwords",
               registrations: "registrations",
               sessions: "sessions"
             },
             path_names: {
               sign_up: "join",
               sign_in: "login",
               sign_out: "logout"
             },
             path: ""

  # Needs to stay near bottom in order to handle "top_level" catch all.
  scope module: :internal do
    get :dashboard
    get :dashboard, as: :user_root
    get :directory
    get :leaving
    get :search
    get :report_page, path: "report/:page_id"
    get ":top_level/:category", action: :category, as: :internal_category
    get ":top_level/:category/download-all", to: redirect("%{top_level}/%{category}")
    post ":top_level/:category/download-all", action: :download_all, as: :download_all_internal_category
    get ":top_level/:category/documents/:document_id", action: :document, as: :internal_category_document
    get ":top_level/:category/videos/:video_id", action: :video, as: :internal_category_video
  end
end
