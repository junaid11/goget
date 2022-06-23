require 'rails_helper'
require 'byebug'

describe 'Jobs Testing Service', :type => :request do
    let(:job) do 
        {
            pickup_address: {
              address: "Lahore, Pak",
              longitude: 102,
              latitude: 203
            },
            
            drop_address: {
              address: "Multan, Pak",
              longitude: 142,
              latitude: 230
            }
        }
    end

    USER = { name: 'albert', email: 'albert@gmail.com', password: '1234' }
    USER_2 = { name: 'john', email: 'john@gmail.com', password: '1234' }

    before (:all) do
        post '/users', params: { user: USER }
        expect(response).to have_http_status(:ok)
        @token = JSON.parse(response.body)['token']

        post '/users', params: { user: USER_2 }
        expect(response).to have_http_status(:ok)
        @token_2 = JSON.parse(response.body)['token']
    end

    it 'Post a job API' do
        post '/jobs', params: { job: job }, headers: { 'Authorization' => @token }
        expect(response).to have_http_status(:ok)
    end

    it 'View My Jobs' do
        get '/my_jobs', headers: { 'Authorization' => @token }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).kind_of?(Array)).to eq(true)
    end

    it "View Other User's Jobs" do
        get '/jobs', headers: { 'Authorization' => @token }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).kind_of?(Array)).to eq(true)
    end

    it 'Claim a job' do
        post '/jobs', params: { job: job }, headers: { 'Authorization' => @token_2 }
        expect(response).to have_http_status(:ok)
        job_id = JSON.parse(response.body)['job_id']
        
        get "/claim_job/#{job_id}", headers: { 'Authorization' => @token }
        expect(response).to have_http_status(:ok)
    end

    it 'Execute a Job' do
        post '/jobs', params: { job: job }, headers: { 'Authorization' => @token_2 }
        expect(response).to have_http_status(:ok)
        job_id = JSON.parse(response.body)['job_id']
        
        get "/claim_job/#{job_id}", headers: { 'Authorization' => @token }
        expect(response).to have_http_status(:ok)

        get "/execute_job/#{job_id}", headers: { 'Authorization' => @token }
        expect(response).to have_http_status(:ok)
    end
end