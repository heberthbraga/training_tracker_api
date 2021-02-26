require 'rails_helper'

describe Api::V1::Authentication::Authenticate, type: :service do
  # subject(:context) { described_class.call(auth_method) }

  # context 'when authenticating with valid info' do
  #   let!(:user) { build(:user, id: 1) }
  #   let(:auth_method) { AuthStubSuccessCommand.call(user) }
  #   let(:exp) { 4.hours.from_now }
  #   let(:token_expiry) { Security::Token::Expiry.new }

  #   before do
  #     new_time = Time.local(2020, 11, 13, 12, 0, 0)
  #     Timecop.freeze(new_time)
  #   end

  #   it 'succeeds' do
  #     random_hex = "236a1f3ac878427216dc464851c9e0cd"
  #     expect(SecureRandom).to receive(:hex).and_return(random_hex)

  #     exp = 1605280800
  #     iat = "1605280800"
  #     expect(token_expiry).to receive(:expire_access).and_return(exp)
  #     expect(token_expiry).to receive(:token_issued_at).and_return(iat)

  #     payload = {exp: exp, iat: iat.to_i, jti: random_hex, provider: "app", sub: 1, uuid: nil}
  #     expect(Api::V1::Jwt::Encode).to receive(:call).with(payload).and_return(EncodeStubCommand.call)

  #     expect(context).to be_success

  #     response = context.result
  #     p response
  #     # expect(user_info).not_to be_empty
  #     # expect(user_info[:exp]).to eq 1605280800
  #     # expect(user_info[:iat]).to eq 1605279600
  #     # expect(user_info[:jti]).to eq "236a1f3ac878427216dc464851c9e0cd"
  #     # expect(user_info[:provider]).to eq
  #   end
  # end

  # context 'when authenticating with invalid info' do
  #   let(:auth_method) { AuthStubFailureCommand.call }

  #   it 'fails' do
  #     user_info = context.result
  #     expect(user_info).to be_nil
  #   end
  # end
end