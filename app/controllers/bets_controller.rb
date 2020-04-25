class BetsController < ApplicationController
    def create
        @user = User.find_by(username: user_params[:username])

        if @user.nil?
            @user = User.create!(username: user_params[:username]) #our create does not allow duplicate users
        end
        
        @bet_pool = BetPool.find_by(title: bet_params[:title])

        if @bet_pool.nil?
            @bet_pool = BetPool.create!(user_id: @user.id, title: bet_params[:title])
        end

        @bet = Bet.new(
            user_id: @user.id,
            wager: bet_params[:wager],
            action: bet_params[:action],
            bet_pool_id: @bet_pool.id
        )

        if @bet.save!
            # bet#save should update the bet_pool(total) and user(salt)
            new_total_salt = @user.salt - @bet.wager.to_i
            User.update(username: @user.username, salt: new_total_salt)
            # @bet_pool.total_salt.to_i += @bet.wager.to_i #(add total column to bet_pools)
            # render a json with some kind of message
            render json: {bet_pool: @bet_pool, total_salt: @bet_pool.total_salt, bet: @bet} #?

        else
            # render a json with an error message
            render @bet.errors.full_messages, status: 422

        end

    end

    private

    def bet_params
        params.require(:bet).permit(:wager, :action, :title)
    end
end