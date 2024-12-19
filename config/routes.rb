Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :qrs do
    resources :qrcodes
    post '/upload_image', to: 'qrcodes#upload_image'
    get '/user_images', to: 'qrcodes#user_images'
    post '/concat_images', to: 'qrcodes#concat_images'
    get '/show_current_final_image', to: 'qrcodes#show_current_final_image'
  end
end
