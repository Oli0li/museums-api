Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "api/v1/museums#index"

  namespace :api do
    namespace :v1 do
      get "/search", to: "museums#search"
    end
  end
end
