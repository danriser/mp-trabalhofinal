# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      scope 'user' do
        get 'index', to: 'user#index'
        get 'show/:id', to: 'user#show'
        get 'login', to: 'user#login'
        post 'create', to: 'user#create'
        delete 'delete/:id', to: 'user#delete'
        patch 'update/:id', to: 'user#update'
      end
      scope 'preference' do
        get 'index', to: 'preference#index'
        get 'show/:id', to: 'preference#show'
        post 'create', to: 'preference#create'
        delete 'delete/:id', to: 'preference#delete'
        patch 'update/:id', to: 'preference#update'
      end
      scope 'group' do
        get 'index', to: 'group#index'
        get 'show/:id', to: 'group#show'
        delete 'delete/:id', to: 'group#delete'
        post 'create', to: 'group#create'
        patch 'update/:id', to: 'group#update'
      end
      scope 'match' do
        get 'index', to: 'match#index'
        get 'show/:id', to: 'match#show'
        post 'create', to: 'match#create'
        post 'find', to: 'match#faz_match'
        delete 'delete/:id', to: 'match#delete'
        patch 'update/:id', to: 'match#update'
      end
      scope 'list_prefs' do
        get 'index', to: 'list_prefs#index'
        get 'show/:user_id', to: 'list_prefs#show'
        post 'create', to: 'list_prefs#create'
        delete 'delete/:id', to: 'list_prefs#delete'
        delete 'delete_user_prefs/:user_id', to: 'list_prefs#delete_user_prefs'
      end
      scope 'list_groups' do
        get 'index', to: 'list_groups#index'
        get 'user_groups/:user_id', to: 'list_groups#user_groups'
        get 'group_users/:group_id', to: 'list_groups#group_users'
        post 'create', to: 'list_groups#create'
        delete 'delete/:id', to: 'list_groups#delete'
      end
      scope 'chat' do
        get 'index', to: 'chat#index'
        get 'show/:id', to: 'chat#show'
        delete 'delete/:id', to: 'chat#delete'
        post 'create', to: 'chat#create'
      end
      scope 'message' do
        get 'index', to: 'message#index'
        get 'user_msgs/:user_id', to: 'message#user_msgs'
        get 'show/:id', to: 'message#show'
        delete 'delete/:id', to: 'message#delete'
        delete 'user_msgs_delete/:user_id', to: 'message#user_msgs_delete'
        get 'chat_msgs/:chat_id', to: 'message#chat_msgs'
        post 'create', to: 'message#create'
      end
    end
  end
end
