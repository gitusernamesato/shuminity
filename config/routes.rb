Rails.application.routes.draw do
  namespace :public do
    get 'tags/show'
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
    
    # resources :cart_items, only: [:index, :update, :destroy, :create] do
    #   collection do
    #     delete "/destroy_all" => "cart_items#destroy_all"
    #   end
    # end

    # resources :orders, only: [:new, :create, :index, :show] do
    #   collection do
    #   post "confirm"
    #   get "thanks"
    #   end
    # end
   end

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
