class UsersController < ApplicationController
    skip_before_action :authenticate

    def create
        user = User.new(user_params)
        if user.save
            token = jwt_encode(user_id: user.id)
            render status: 200, json: { token: token }
        else
            render status: 422, json: { error: user.errors.messages }
        end
    end

    private
    
    def user_params
        params.require(:user).permit(:name, :email, :password)
    end
end
