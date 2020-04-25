class UsersController < ApplicationController

    def show 
        #shows user current salt
        @user = User.find(params[:id])
        render json: "#{@user.username} has #{@user.salt} saltines"
    end

    def create 
        #a user will only be created if they are not in 
        #db upon creating a bet
        @user = User.new(:username)
        if @user.save
            redirect_to user_url(@user)
        else 
           render json: @user.errors.full_message, status: 422
        end 

    end 


end