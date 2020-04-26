class BetPoolsController < ApplicationController


    def index 
        @bet_pools = BetPool.all 
        current_bet_pools = []
        @bet_pools.each do |bet_pool| #
            current_bet_pools << "#{bet_pool.title} #{bet_pool.total_salt}"
        end 
        render json: {message: current_bet_pools.join("\n")}
    end

    
    def show
        @bets = BetPool.find(params[:id]).bets
        response = "hi"
        bets_and_users = @bets.includes(:user)
        response_arrays = bets_and_users.map{|bau| [bau.user.username, bau.wager, bau.action]}
        response = response_arrays.map{|el| el.join(" ")}

        render json: {message: response.join("\n")}
    end

    def update
        @bet_pool = BetPool.find(params[:id])
        @user = User.find_by(username: user_params[:username])
        @bet = Bet.find_by(user_id: @user.id, bet_pool_id: @bet_pool.id)

        # add users to array based on what their action was (true/false)
        

        if @bet_pool.winner
            # distribute pool (.total_salt) by dividing by array length
        end
        #@duskstone: !bet won alex is gonna blow up
        #patch 'bet_pools' do 'bet_pools#update' 
        #   => params{user:{username:duskstone}, bet_pool:{title: 'alex..'}}
        # find the bet that user made for bet_pool title 'alex...'
        #bet_pool.winner.nil? there is no winner
        #bet_pool.winner = true then distribute salties to all true bets
        #etc.
    end
end