Rails.application.routes.draw do
  root 'tickets#new'
  namespace :admin do
    get '/', to: 'tickets#index', as: :root
    resources :tickets, only: [:index, :new, :create, :show, :update], param: :reference
    resources :users
    resources :statuses
  end
  devise_for :admin, { class_name: 'User' }
  resources :tickets, only: [:new, :create, :show, :update], param: :reference, path: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
