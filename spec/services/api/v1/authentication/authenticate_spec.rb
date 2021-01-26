require 'rails_helper'

describe Api::V1::Authentication::Authenticate, type: :service do
  subject(:context) { described_class.call(auth_method) }

  context 'when authenticating with valid info' do
    let!(:user) { build(:user, id: 1) }
    let(:auth_method) { AuthStubSuccessCommand.call(user) }
    let(:exp) { 4.hours.from_now }

    before do
      new_time = Time.local(2020, 11, 13, 12, 0, 0)
      Timecop.freeze(new_time)
    end

    it 'succeeds' do
      allow(Api::V1::Jwt::Encode).to receive(:call).with({provider: 'app', user_id: user.id}, exp).and_return(EncodeStubCommand.call)

      expect(context).to be_success

      user_info = context.result

      expect(user_info).not_to be_empty
      expect(user_info[:token]).to eq 'token'
      expect(user_info[:user_id]).to eq user.id
      expect(user_info[:first_name]).to eq user.first_name
      expect(user_info[:last_name]).to eq user.last_name
    end
  end

  context 'when authenticating with invalid info' do
    let(:auth_method) { AuthStubFailureCommand.call }

    it 'fails' do
      user_info = context.result
      expect(user_info).to be_nil
    end
  end
end