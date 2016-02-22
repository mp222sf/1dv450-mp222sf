Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  resources :authentications
  resources :apikeys
  resources :menu, only: [:index, :show]
  resources :pizzerias, only: [:index, :show] do
    resources :menus, only: [:index]
    resources :tags, only: [:index]
  end
  resources :menus, only: [:index]
  resources :positions, only: [:index, :show]
  
  
  
  post 'login' => 'welcome#login', as: :login
  get 'logout' => 'welcome#logout', as: :logout
  get 'account' => 'welcome#account', as: :account
  get 'showAll' => 'authentications#showAll', as: :showAll
  
  constraints(latitude: /\d+\.\d+/, longitude: /\d+\.\d+/) do
    get 'pizzerias/:latitude/:longitude' => 'pizzerias#coordinates', as: :coordinates
  end
  
  
  
  #match "/positions/:latitude/:longitude(/:range)", :to => "positions#coordinates", :as => "coordinates", :constraints => {:range => /\d+/}

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
