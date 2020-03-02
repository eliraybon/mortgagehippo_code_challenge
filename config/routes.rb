Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do

    resources :coins do 
      collection do 
        get :total 
      end
    end
    
  end
end
