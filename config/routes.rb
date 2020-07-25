Rails.application.routes.draw do
  # user
  get "users/index" => "users#index"
  get "signup" => "users#new"
  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  get "users/:id/likes" => "users#likes" 
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get "users/:id" => "users#show" 

  # posts
  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new" 
  get "posts/:id/" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/destroy" => "posts#destroy"
  post "posts/:id/update" => "posts#update"
  post "posts/create" => "posts#create"

  # home
  get "/" => "home#top"
    #初期値が右記になっているので注意　→　get 'home/top'
  get "about" => "home#about"
    # aboutをabootって書いてミスらない。。。
    # For detail]s on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  # like
  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

end
