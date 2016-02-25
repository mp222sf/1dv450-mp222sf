Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  resources :authentications
  resources :apikeys
  
  post 'login' => 'welcome#login', as: :login
  get 'logout' => 'welcome#logout', as: :logout
  get 'account' => 'welcome#account', as: :account
  get 'showAll' => 'authentications#showAll', as: :showAll
  
  
  # API Version 1
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :pizzerias, only: [:index, :show, :create, :destroy] do
        resources :menus, only: [:index]
        resources :tags, only: [:index]
      end
      resources :tags, only: [:index, :show, :create, :update, :destroy] do
        resources :pizzerias, only: [:index]
      end
      resources :menus, only: [:index, :show, :create, :update, :destroy]
      resources :positions, only: [:index, :show, :create, :update, :destroy]
      resources :creator, only: [:show, :create, :update, :destroy]
      resources :dishes, only: [:create, :update, :destroy]
    
      get 'search/:word' => 'search#search', as: :search
      get 'errorApiKey' => 'error#apikey', as: :errorApiKey
      get 'error' => 'error#index', as: :error
      
      constraints(latitude: /\d+\.\d+/, longitude: /\d+\.\d+/) do
        get 'pizzerias/:latitude/:longitude' => 'pizzerias#coordinates', as: :coordinates
      end
    end
  end
  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
