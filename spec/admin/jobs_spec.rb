require 'rails_helper'
require 'byebug'

describe 'Admin Jobs Testing', :type => :request do
    USER = {name: 'admin', email: 'admin@gmai.com', password: '1234', admin: true }
    let(:admin) { User.create(USER)}

    before (:all) do
        post '/users', params: { user: USER }
        expect(response).to have_http_status(:ok)
        @token = JSON.parse(response.body)['token']
    end

    it 'List all jobs' do
        get '/admin/jobs', headers: { 'Authorization' => @token }
        expect(JSON.parse(response.body).count).to eq(Job.count)
    end
end