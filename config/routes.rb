Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "projects#index"

  resources :projects do
    resources :comments, only: [:create] do
      collection do
        post :next
      end
    end
  end
end
