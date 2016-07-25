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
  get '/projects_and_donations' => 'donations#index'
  post '/donations' => 'donations#create'
end
