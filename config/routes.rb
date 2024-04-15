Rails.application.routes.draw do
  
  get '/api/features', to: 'features#index'

  post '/features/:feature_id/comments', to: 'comments#create'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "up" => "rails/health#show", as: :rails_health_check
end
