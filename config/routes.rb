Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace "api" do
    namespace "v1" do
      scope "user" do
        get "index", to: "user#index"
        get "show/:id", to: "user#show"
        post "create", to: "user#create"
        delete "delete/:id", to: "user#delete"
        patch "update/:id", to: "user#update"
      end
      scope "preference" do
        get "index", to: "preference#index"
        get "show/:id", to: "preference#show"
        post "create", to: "preference#create"
        delete "delete/:id", to: "preference#delete"
        patch "update/:id", to: "preference#update"
      end
      scope "group" do
        get "index", to: "group#index"
        get "show/:id", to: "group#show"
        delete "delete/:id", to: "group#delete"
        post "create", to: "group#create"
        patch "update/:id", to: "group#update"
      end
      scope "match" do
        get "index", to: "match#index"
        get "show/:id",to: "match#show"
        post "create", to: "match#create"
        delete "delete/:id", to: "match#delete"
        patch "update/:id", to: "match#update"
      end
      scope "list_prefs" do
        get "index",to: "list_prefs#index"
        get "show/:user_id",to: "list_prefs#show"
        post "create", to: "list_prefs#create"
        delete "delete/:id",to: "list_prefs#delete"
        delete "delete_user_prefs/:user_id",to: "list_prefs#delete_user_prefs"
      end
      scope "list_groups" do
        get "index",to: "list_groups#index"
        get "user_groups/:user_id",to: "list_groups#user_groups"
        get "group_users/:group_id", to:"list_groups#group_users"
        post "create",to: "list_groups#create"
        delete "delete/:id",to: "list_groups#delete"
      end
    end
  end
end
