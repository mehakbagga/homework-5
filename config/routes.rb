Rails.application.routes.draw do
  
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  root "posts#index"

  resources :users, only: [:new, :create, :edit, :update]

  get "/users/:id/change_password" => "users#change_password", :as => :change_user_password
  patch "/users/:id/change_password" => "users#patch_changed_password" 


  resource :session, only: [:new, :create, :destroy]

end
