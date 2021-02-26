require 'rails_helper'

RSpec.describe Security::Token::Whitelist do
  subject(:whitelist) { described_class.new }

  let(:valid_stub_token) {
    {
      provider: 'email',
      sub: '1',
      jti: 'xxx'
    }
  }

  context 'when a refresh token is valid' do
    before do
      whitelist.add valid_stub_token
    end

    it 'returns true' do
      expect(whitelist.valid?(valid_stub_token)).to be_truthy
    end
  end

  context 'when a token is going to be refreshed' do
    before do
      whitelist.add valid_stub_token
      whitelist.refresh 'email', '1'
    end

    it 'returns true' do
      expect(whitelist.refresh?(valid_stub_token)).to be_truthy
    end
  end

  context 'when removing a token' do
    before do
      whitelist.add valid_stub_token
    end

    it 'raises an exception' do
      whitelist.remove valid_stub_token

      expect {
        whitelist.get(valid_stub_token)
      }.to raise_error(Service::Errors::InvalidToken)
    end
  end

  context 'when revoking a token' do
    before do
      whitelist.add valid_stub_token
    end

    it 'raises an exception' do
      whitelist.revoke 'email', '1'

      expect {
        whitelist.get(valid_stub_token)
      }.to raise_error(Service::Errors::InvalidToken)
    end
  end
end