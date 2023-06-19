Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace "api" do
    namespace "v1" do
      scope "user" do
        get "index", to: "user#index"
        get "show/:id", to: "user#show"
        post "create", to: "user#create"
        delete "delete/:id", to: "user#delete"
      end
      scope "preference" do
        get "index", to: "preference#index"
        get "show/:id", to: "preference#show"
        post "create", to: "preference#create"
        delete "delete/:id", to: "preference#delete"
      end
    end
  end
end
