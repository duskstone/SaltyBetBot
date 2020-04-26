class BetPoolsController < ApplicationController

    def index 
        @bet_pools = BetPool.where(winner: nil)
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
        title = "#{@bets.first.bet_pool.title}\n"
        response = response_arrays.map{|el| el.join(" ")}

        render json: {message: title + response.join("\n")}
    end

    def update
        @bet_pool = BetPool.find_by(title: bet_pool_params[:title])
        @user = User.find_by(username: user_params[:username])

        if @bet_pool
            @bet_pool.update(
                winner: bet_pool_params[:winner]
            )
            unless @bet_pool.winner.nil?
                # @bet = Bet.find_by(user_id: @user.id, bet_pool_id: @bet_pool.id)
                # add users to array based on what their action was (true/false)
                # distribute pool (.total_salt) by dividing by array length

                render json: {message: "The pool is closed, #{@bet_pool.winner} wins!"}
            end
        else
            render json: {message: "Bet pool not found. Enter '!bet' to see all open pools!"}
        end
    end

    private

    def bet_pool_params
        params.require(:bet_pool).permit(:title, :winner)
    end
end