Rails.application.routes.draw do
  root 'welcome#index'
  resources :messages, only: [:create]
  get '/rush' => 'rush#index'
end
