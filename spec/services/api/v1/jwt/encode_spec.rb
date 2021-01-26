require 'rails_helper'

describe Api::V1::Jwt::Encode, type: :service do
  context 'when encoding for a given payload' do
    let(:payload) { {provider: 'app'} }

    it 'returns and encoded token' do
      command = described_class.call payload

      encoded_token = command.result

      expect(encoded_token).not_to be_empty
    end
  end
end