Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'help', to: 'bookie#help'
  
  post 'bets', to: 'bets#create'
  
  get 'users/:id', to: "users#show"

  get 'bet_pools', to: "bet_pools#index"
  patch 'bet_pools', to: "bet_pools#update"
  get 'bet_pools/:id', to: "bet_pools#show" #shows all bets mad for the betting_pool


# add winner col to betting_pool, which is null until a winner is assigned
# bet#create expects params needed to create a bet, creates betting_pool and user if do next
# user#show returns the user's total salt
# create bookie controller for methods outside RESTful controllers
# if betting_pool is updated with a winner, should distribute the wagers to winning players


  resources :bookie, only:[:index]

  resources :bet, only:[:create]

end
