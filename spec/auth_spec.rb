require 'rails_helper'
require 'byebug'

describe "Authentication", :type => :request do
  let(:user) {{name: 'albert', email: 'albert@gmail.com', password: '1234'}}

  before do 
    post '/users', params: { user: user }
  end

  it 'Sign Up' do
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['token'].present?).to eq(true)
  end

  before do
    post '/login', params: { email: user[:email], password: user[:password] }
  end

  it 'login' do
    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)['token'].present?).to eq(true)
  end
end