Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  post '/login', to: 'sessions#login'
  resources :jobs
  get '/my_jobs', to: 'jobs#my_jobs'
  get 'claim_job/:id', to: 'jobs#claim_job'
  get 'execute_job/:id', to: 'jobs#execute_job'

  namespace :admin do
    resources 'jobs'
  end
end
