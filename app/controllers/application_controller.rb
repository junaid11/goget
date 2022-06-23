class ApplicationController < ActionController::API
    include JsonWebToken

    before_action :authenticate

    private
    def authenticate
        begin
            header = request.headers['Authorization']
            header = header&.split(" ")&.last
            decoded = jwt_decode(header)
            @current_user = User.find_by(id: decoded[:user_id])
            render status: 403, json: { message: "User Doesn't exist" } unless @current_user
        rescue
            puts decoded
            render status: 400, json: { message: "Invalid Auth Token" }
        end
        
    end
end
