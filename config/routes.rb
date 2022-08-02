Rails.application.routes.draw do
 devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about'
    resources :posts, only: [:index, :new, :edit, :show, :update, :create, :destroy]
    resource :customers do
      get '/my_page' => 'customers#show'
      get '/customers' => 'customers#index'
      get '/information/edit' => 'customers#edit'
      patch  '/information' => 'customers#update'
    end

  end


  namespace :admin do
    resources :types, only: [:index, :create, :edit, :update]
    resources :alcohols, only: [:index, :create, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
