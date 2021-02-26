require 'rails_helper'

describe Api::V1::Authentication::Authorize, type: :service do
  subject(:context) { described_class.call(headers) }

  context 'when token is not present' do
    let(:headers) { 
      {
        'Authorization' => 'Bearer '
      } 
    }

    it 'fails' do      
      expect(context).to be_failure

      user = context.result
      errors = context.errors
      messages = errors[:invalid_token]

      expect(user).to be_nil
      expect(errors).not_to be_empty
      expect(messages.first).to eq 'Invalid Token.'
    end
  end

  context 'when token is present with wrong credentials' do
    let!(:user) { create(:registered) }
    let!(:identity) { create(:identity, provider: 'app', uuid: nil, user: user) }
    let!(:token) { Api::V1::Jwt::Encode.call({provider: 'app', uuid: nil, sub: 10} ).result }
    let(:headers) { 
      {
        'Authorization' => "Bearer #{token}"
      } 
    }

    it 'fails' do
      expect(context).to be_failure

      user = context.result
      errors = context.errors
      messages = errors[:invalid_credentials]

      expect(user).to be_nil
      expect(errors).not_to be_empty
      expect(messages.first).to eq 'Wrong Credentials.'
    end
  end

  context 'when token is present with correct credentials' do
    let!(:user) { create(:registered) }
    let!(:identity) { create(:identity, provider: 'app', user: user) }
    let!(:token) { Api::V1::Jwt::Encode.call({provider: 'app', uuid: nil, sub: user.id} ).result }
    let(:headers) { 
      {
        'Authorization' => "Bearer #{token}"
      } 
    }

    it 'succeeds' do
      expect(context).to be_success

      current_user = context.result
      expect(current_user).not_to be_nil
      expect(current_user.first_name).to eq user.first_name
    end
  end
end