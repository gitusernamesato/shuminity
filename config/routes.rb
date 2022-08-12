Rails.application.routes.draw do
  namespace :public do
    get 'posts/show'
    get 'posts/edit'
    get 'posts/index'
  end
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
   scope module: :public do
    root to: "homes#top"
    get "homes/about"

    resources :users, except: [:destroy, :create] do
      get "confirm"
      patch "withdraw"
    end


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
