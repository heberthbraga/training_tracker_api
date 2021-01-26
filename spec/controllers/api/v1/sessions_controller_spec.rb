require 'rails_helper'

describe Api::V1::SessionsController, type: :request do
  context 'when invalidating an existing session' do
    before(:each) do
      user = create(:registered)
      create(:identity, provider: 'email', user: user)
      
      post '/api/v1/sessions/email', params: { email: user.email, password: user.password }

      response = json_response

      expect(response).not_to be_nil
      expect(response[:user_id]).to eq user.id
    end

    it 'succeeds' do
      delete '/api/v1/sessions/invalidate'

      response = json_response

      expect(response).not_to be_nil
      expect(response[:status]).to eq 'ok'
      expect(response[:code]).to eq 200
    end
  end
  
  context 'when creating authentication by email/password' do
    before(:each) do
      @user = create(:registered)
    end

    it 'succeeds' do
      post '/api/v1/sessions/email', params: { email: @user.email, password: @user.password }

      response = json_response

      expect(response).not_to be_nil
      expect(response[:user_id]).to eq @user.id
    end

    it 'fails when email and password not provided' do
      post '/api/v1/sessions/email'

      response = json_response

      expect(response).not_to be_nil
      expect(response[:status]).to eq 'incorrect_credentials'
    end

    it 'fails when credentials are wrong' do
      post '/api/v1/sessions/email', params: { email: 'test@gmail.com', password: '123' }

      response = json_response

      expect(response).not_to be_nil
      expect(response[:status]).to eq 'authentication_failed'
    end
  end
end
