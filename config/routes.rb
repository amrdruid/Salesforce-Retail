Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: 'json'} do
    scope module: :v1  do
      resources :dealers, only: [] do
        post :add_point_of_sales_dealers
        get :dealers_within_range
      end
    end
  end
end
