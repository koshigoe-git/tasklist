Rails.application.routes.draw do

  #root to: がトップページ
  root to: 'tasks#index'
  
  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete 'logout', to: "sessions#destroy"
  
  get 'signup', to: 'users#new'

  resources :tasks
  resources :users, only: [:index, :show, :new, :create]
end

  #resources :tasksの詳細.
  #get "/", to: "tasks#index" または root_url
  #get "/tasks/:id", to: "tasks#show" またはtask
  #get "/tasks/new", to: "tasks#new" または new_task
  #get "/tasks/:id/edit", to: "tasks#edit" または edit_task
  #putch "/tasks/:id", to: "tasks#update"
  #put "/tasks/:id", to: "tasks#update"
  #delete "/tasks/:id", to: "tasks#destroy"