Rails.application.routes.draw do
  get 'home/index'

  root to: 'home#index'
  get 'home', to: 'home#index', as: :home

  # routes for the api and respective versions
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'itemsByRedeemer/:redeemer_id' => 'purchase#itemsByRedeemer', controller: 'purchase'
      get 'community' => 'purchase#community', controller: 'purchase'
      get 'redeem/:id' => 'redeem#redeem', controller: 'redeem'
      get ':endpoint' => 'api#index', controller: 'api'

      get ':endpoint/:id' => 'api#index', controller: 'api'
      get ':endpoint/:id/:related_endpoint' => 'api#index', controller: 'api'


      post 'cards' => 'card#create', controller: 'card'
      post 'createPurchase' => 'purchase#create', controller: 'purchase'
      post ':endpoint/:id/:related_endpoint' => 'api#index', controller: 'api'
    end

    # in the future, we can simply do
    # namespace :v2 do
    #   resources :user
    # end
    # etc. for each endpoint
  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
