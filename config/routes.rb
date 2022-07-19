Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root "posts#new"
  get '/', to: 'posts#index', as: :root

  resources :posts do
    # routes written inside of the block passed a resource method will be prefixed by a path corresponding to the passed in symbol
    # in this case, all the nested routes will be prefixed with '/questions/questions_id'

    # post 'questions', to: 'questions#create', as: :create_question
    # /questions method post
    # /questions/:question_id/answers method post
    resources :answers, only: [:create, :destroy]
    # except: [:show, :new, :edit, :update]
  end

end
