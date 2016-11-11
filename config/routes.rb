Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :members, controllers: { registrations: 'members/registrations', sessions: 'members/sessions' }
  devise_scope :member do
    get 'members/sign_out' => 'members/sessions#destroy'
  end
  resources :messages, only: [:create] # TODO - this controller doesn't exist
  get '/rush' => 'rush#index'
  get '/tweets' => 'tweets#index'
  namespace :calendar do
    resources :events, only: %i[index show]
  end
  get '/calendar' => 'calendar/events#index'

  get '/projects/:project_id/donations/new' => 'donations#new'
  get '/projects/:project_id/donations'     => 'donations#index'
  post '/projects/:project_id/donations'    => 'donations#create'
  get '/projects_and_donations'             => 'projects#index'
  resources :projects, only: [:edit, :create, :destroy, :update] do
    post '/complete'                        => 'projects#complete'
  end
  get '/alumni'                             => 'alumni#index'
  resources 'roles', only: %i[edit update]
  resources 'pictures', only: %i[create destroy]
  resources 'unassociated_pictures', only: %i[create destroy]
  get '/profile'                            => 'members#edit'
  patch '/profile'                          => 'members#update'

  namespace :forum do
    get '/'                              => 'channels#index'
    resources :channels, only: [:create, :update, :new, :destroy, :show] do
      resources :posts, only: [:create, :update, :destroy] do
        resources :reactions, only: [:create, :destroy]
      end
    end
  end
end
