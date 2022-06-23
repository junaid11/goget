class AdminController < ApplicationController
    include JsonWebToken

    skip_before_action :authenticate
    before_action :authenticate_admin

    private
    def authenticate_admin
        begin
            header = request.headers['Authorization']
            header = header&.split(" ")&.last
            decoded = jwt_decode(header)
            @current_user = User.find_by(id: decoded[:user_id])
            render status: 403, json: { message: "Not Authorized for this action" } unless @current_user&.admin
        rescue
            render status: 400, json: { message: "Invalid Auth Token" }
        end
        
    end
end
