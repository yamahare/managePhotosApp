Rails.application.routes.draw do
  root to: 'photos#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # 写真
  resources :photos, only: %i(index create new)
end
