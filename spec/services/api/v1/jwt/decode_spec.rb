require 'rails_helper'

describe Api::V1::Jwt::Decode, type: :service do
  JWT_SECRET = Rails.application.secrets.secret_key_base

  context 'when decoding a given token' do
    let(:payload) { {provider: 'app', user_id: 1} }

    before do
      @token = Api::V1::Jwt::Encode.call(payload).result
    end

    it 'returns the decoded payload' do
      command = described_class.call @token

      decoded_payload = command.result

      expect(decoded_payload).not_to be_empty
      expect(decoded_payload[:provider]).to eq payload[:provider]
      expect(decoded_payload[:user_id]).to eq payload[:user_id]
    end

    it 'raises an JWT::ExpiredSignature exception' do
      allow(JWT).to receive(:decode).with(@token, JWT_SECRET).and_raise(JWT::ExpiredSignature.new)

      command = described_class.call @token

      result = command.result

      expect(result).to be false
    end

    it 'raises an JWT::DecodeError exception' do
      allow(JWT).to receive(:decode).with(@token, JWT_SECRET).and_raise(JWT::DecodeError.new)

      command = described_class.call @token

      result = command.result
      
      expect(result).to be false
    end
  end
end