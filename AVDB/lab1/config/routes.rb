require 'sidekiq/web'


Rails.application.routes.draw do
  # The priority is based upon order of creation: balance created -> highest priority.
  # See how all your routes lay out with "rake routes".
  mount Sidekiq::Web, at: '/sidekiq'
  # You can have the root of your site routed with "root"
   root 'home#index'
   get 'home/:index' => 'home#index'

   get 'balance/regenerate' => 'balance#regenerate'
   post 'balance/send_email' => 'balance#send_email'
   resources :balance, only: [:show, :index]

   get 'currency/get_history' => 'currency#get_history'
   resources :currency

   resources :database
   post 'database/send_email' => 'database#send_email'
   post 'database/create_client' => 'database#create_client'

     # get 'balance/'=> 'balance#index' , as: 'first_lab'
     # get 'balance/get_balances'=> 'balance#get_balances'
     # get '*path' => redirect('/')

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
