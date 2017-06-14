Rails.application.routes.draw do

  get 'accounts/select_account'
  #get 'accounts/destroy_account'
  #get "log_out" => "sessions#destroy", :as => "log_out"
  
  get 'companies/fake'
  get 'transactions/yearwise'
  get 'transactions/monthwise'
  get 'transactions/daily_statement'
  get 'transactions/weekly_statement'
  get 'transactions/search_results'
  get 'accounts/yearwise_acc'
  get 'accounts/monthwise_acc'
  get 'perticulars/yearwise_perticular'
  get 'perticulars/monthwise_perticular'

  #get "transactions/log_in_session"
  # get "log_out_session" => "sessions#destroy", :as => "log_out_session"
  # get "log_in_session" => "sessions#index", :as => "log_in_session"
  # resources :sessions

  #this is for onclick event
  get 'companies/select_accounts'
  get '/accounts/select_balance'
  get 'banks/welcome'

  resources :transactions
  resources :perticulars 
  devise_for :users
  resources :accounts
  resources :banks do 
    resources :accounts,only: [:show]
  end 
  resources :branches
  resources :companies do 
    resources :accounts,only: [:show]
  end  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: "banks#welcome"


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
