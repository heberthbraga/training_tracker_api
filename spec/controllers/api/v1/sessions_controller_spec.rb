require 'rails_helper'

describe Api::V1::SessionsController, type: :request do
  context 'when creating authentication by email/password' do
    before(:each) do
      @user = create(:registered)
    end

    it 'succeeds' do
      post '/api/v1/sessions/email', params: { email: @user.email, password: @user.password }

      response = json_response

      expect(response[:access_token]).not_to be_nil
      expect(response[:refresh_token]).not_to be_nil
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
