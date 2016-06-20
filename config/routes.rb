Rails.application.routes.draw do
  devise_for :members
  root 'welcome#index'
  resources :messages, only: [:create] # TODO - this controller doesn't exist
  get '/rush' => 'rush#index'
  get '/tweets' => 'tweets#index'
  namespace :calendar do
    resources :events, only: %i[index show]
  end
  get '/calendar' => 'calendar/events#index'
end
