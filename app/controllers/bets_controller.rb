class BetsController < ApplicationController

    def index
        #eventually fill out this message
        #replace with custom route
        render json: {message: "NO HELP!"}
    end

    def create
        #what if the user has no salt left?
        @bet = Bet.new(
            user_id: get_user.id,
            wager: bet_params[:wager],
            action: bet_params[:action],
            bet_pool_id: get_bet_pool.id
        )

        if @bet.save!
            get_user.update(salt: get_user.salt - @bet.wager.to_i)

            msg1 = "#{get_user.username} bet #{@bet.wager} on #{@bet.action},"
            msg2 = "#{@bet_pool.title} now has a pot of #{@bet_pool.total_salt}!"
            render json: {message: (msg1 + "\n" + msg2)}
        else
            render json: @bet.errors.full_messages, status: 422
        end

    end

    private

    def bet_params
        params.require(:bet).permit(:wager, :action, :title)
    end

    def get_user
        @user ||= User.find_by(username: user_params[:username])

        if @user.nil?
            @user = User.create!(username: user_params[:username]) #our create does not allow duplicate users
        end

        @user
    end

    def get_bet_pool
        @bet_pool ||= BetPool.find_by(title: bet_params[:title])

        #what if there is another bet with a really similar name?
        #how can we "sanitize" the bet pool names to make them more standardized?
        #ie removing punctuation
        if @bet_pool.nil?
            @bet_pool = BetPool.create!(user_id: get_user.id, title: bet_params[:title])
        end

        @bet_pool
    end
end