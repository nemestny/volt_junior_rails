Rails.application.routes.draw do

  # namespace :api do
  #   namespace :v1 do
  #     get 'users/edit'
  #     get 'users/update'
  #   end
  # end
  root to: 'api/v1/users#edit'

  namespace :api do
    namespace :v1 do
      # constraints lambda { |req| req.format == :json } do #routes for json only
        resources :posts, only: [:index, :create, :show]
        resources :users, only: [:edit, :update]
        # root to: 'users#edit'
      # end
    end
  end


  
  post 'authenticate', to: 'authentication#authenticate'
#  get '*path', to: 'api/v1/home#index', via: [:get, :post, :patch, :delete]

end
