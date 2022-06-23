class SessionsController < ApplicationController
    skip_before_action :authenticate
    
    def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            render status: 200, json: { token: jwt_encode(user_id: user.id) }
        else
            render status: 403, json: { message: "Invalid Credentials" }
        end
    end
end