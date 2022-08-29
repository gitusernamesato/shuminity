Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
   scope module: :public do
    root to: "homes#top"
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
    resources :users, except: [:destroy, :create, :edit] do
      get "confirm"
      # patch "withdraw"
    end

    resources :posts, except: [:new] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :tags, only: [:show]

    get "search"=>"searches#search"

    resources :groups do
      get "join" => "groups#join"
      get "leave" => "groups#leave"
      resources :chat_messages, only: [:index, :create, :destroy]
    end

   end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"
    resources :posts, only: [:show, :destroy, :update]
    resources :users, only: [:show, :index, :update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
