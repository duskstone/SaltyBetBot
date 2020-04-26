class BetPoolsController < ApplicationController

    def index 
        @bet_pools = BetPool.where(winner: nil)
        current_bet_pools = []
        
        @bet_pools.each do |bet_pool| #
            current_bet_pools << "#{bet_pool.title} #{bet_pool.total_salt} #{bet_pool.winner}"
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
            sample_bet = @bet_pool.bets.find_by(bets: {user_id: @user.id})

            #!!!! ASSUMES BOOLEAN ACTION & WINNING ACTION !!!!!
            winning_action = nil
            if bet_pool_params[:winner] #bot passes bet_pool[winner] = true in query if user won
                winning_action = sample_bet.action
            else  #bot passes bet_pool[winner] = false in query if user won
                winning_action = sample_bet.action!
            end
            #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

            @bet_pool.update(
                winner: winning_action
            )
            unless @bet_pool.winner.nil?
                @bet = Bet.find_by(user_id: @user.id, bet_pool_id: @bet_pool.id)
                render json: {message: "The pool is closed, #{@bet_pool.winner} wins!"}

                distribute_winnings(winning_action, @bet_pool)
            end
        else
            render json: {message: "Bet pool not found. Enter '!bet' to see all open pools!"}
        end
    end

    def distribute_winnings(winning_action, bet_pool) 
        winning_bets = @bet_pool.bets.where(action: winning_action)
        winning_bets.each do |winning_bet|
            winnings = winning_bet.user.salt * 2 #change to proprtional returns
            winning_bet.user.update(salt: winnings)
        end 
        bet_pool.destroy
    end 

    private

    def bet_pool_params
        #update to look at body instead of params
        params.require(:bet_pool).permit(:title, :winner)
    end
end

# def distribute_winnings(winning_action, bet_pool)
        # @users = bet_pool.users
            # winnners = [] #need a indication to what is the winning or losing action
            # @users.each do |user|
            #     if user.action == winning_action #presumably in this case bet creator lost
            #         winnners << user
            #     end 
            # end 

            # winnings = @bet_pool.total_salt / winnners.length #seperate winnings
            # winners.each { |wu| wu.salt += winnings } # wu => winning_user

            #delete bet pool at the end of distribution 
            #also deleting related bets
#         bet_pool.destroy
# end 