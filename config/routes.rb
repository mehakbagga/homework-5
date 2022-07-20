Rails.application.routes.draw do
  
  root "posts#index"

  resources :posts do
    resources :answers, only: [:create, :destroy]
    
  end

end
