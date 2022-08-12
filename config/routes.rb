Rails.application.routes.draw do
 devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about'
    resources :posts, only: [:index, :new, :edit, :show, :update, :create, :destroy] do
      collection do
        get "/post_search" => "posts#post_search"
      end
      resources :post_comments, only: [:create, :destroy]
      resource :likes, only:[:create, :destroy]
    end
    resources :customers, only: [:show, :index, :edit, :update] do
      delete :destroy_all, on: :collection
      resource :relationships, only: [:create, :destroy]
        get 'followings' => 'relationships#followings', as: 'followings'
        get 'followers' => 'relationships#followers', as: 'followers'
      end
    resources :time_lines, only: [:create, :destroy, :show, :index] do
      resources :time_line_comments, only: [:create, :destroy]
    end
    resources :chats, only: [:create, :show]

    resources :contacts, only: [:new, :create]
    post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
    post 'contacts/back', to: 'contacts#back', as: 'back'
    get 'done', to: 'contacts#done', as: 'done'

    resources :notifications do
      delete :destroy_all, on: :collection
    end
  end


  namespace :admin do
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
    resources :time_lines, only: [:index, :show, :destroy] do
      resources :time_line_comments, only: [:destroy]
    end
    resources :types, only: [:index, :create, :edit, :update]
    resources :alcohols, only: [:index, :create, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
