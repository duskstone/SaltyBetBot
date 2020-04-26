Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'bets', to: 'bets#index'
  post 'bets', to: 'bets#create'
  
  get 'users/:id', to: "users#show"
  
  get 'bet_pools', to: "bet_pools#index"
  patch 'bet_pools', to: "bet_pools#update"
  get 'bet_pools/:id', to: "bet_pools#show" #shows all bets mad for the betting_pool



# add winner col to betting_pool, which is null until a winner is assigned
# create bookie controller for methods outside RESTful controllers
# if betting_pool is updated with a winner, should distribute the wagers to winning players

end
