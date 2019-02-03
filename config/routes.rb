Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      constraints lambda { |req| req.format == :json } do #routes for json only
        resources :posts, only: [:index, :create, :show]
      end
    end
  end

  get '*path', to: 'api/v1/home#index', via: [:get, :post, :patch, :delete]

end
