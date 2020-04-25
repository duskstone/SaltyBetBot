class ApplicationController < ActionController::Base

    private 

    def user_params 
        params.require(:user).permit(:username)
    end
end
