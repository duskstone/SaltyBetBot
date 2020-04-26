class UsersController < ApplicationController

    def show 
        @user = User.find_by(username: params[:id])
        render json: {message: "#{@user.username} has #{@user.salt} salty doubloons"}
    end

    def create
        @user = User.new(:username)
        if @user.save
            redirect_to user_url(@user)
        else 
           render json: {message: @user.errors.full_message}, status: 422
        end 

    end 
end