Rails.application.routes.draw do
  namespace :admin do
    get 'users/show'
    get 'users/index'
    get 'users/edit'
  end
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
   scope module: :public do
    root to: "homes#top"
    get "homes/about"
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
    resources :users, except: [:destroy, :create] do
      get "confirm"
      patch "withdraw"
    end

    resources :posts, except: [:new] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :tags, only: [:show]
    get "search"=>"searches#search"
   end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }
  
  namespace :admin do
    root to: "homes#top"
    resources :posts, only: [:show, :destroy]
    resources :users, only: [:show, :index, :edit, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
