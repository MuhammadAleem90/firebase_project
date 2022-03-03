Rails.application.routes.draw do
 


  root 'pages#index'
  get    '/' , to: 'pages#index'
  get 	'/signup' , to:'pages#signup'
  get 	'/home' , to:'pages#home'
  
  post 	'/login' , to:'pages#login'
  post 	'/logout' , to:'pages#logout'
  post 	'/signup' , to:'pages#signup'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
