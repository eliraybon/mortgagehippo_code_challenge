Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do

    resources :coins do 
      collection do 
        get :total 
      end
    end

    resources :transactions, only: [:index] do 
      collection do 
        post :deposit
        post :withdrawal
      end
    end

    resources :users, only: [:create] do
      member do 
        get :transactions
      end
    end

  end
end
