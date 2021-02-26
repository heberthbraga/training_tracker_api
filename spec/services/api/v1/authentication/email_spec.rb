require 'rails_helper'

describe Api::V1::Authentication::AuthenticateByEmail, type: :service do
  subject(:context) { described_class.call(email, password) }
  
  context 'when user cannot be found' do
    let!(:email) { 'foo@example.com' }
    let!(:password) { 'test' }

    before do
      create(:registered)
    end

    it 'fails' do
      expect(context).to be_failure

      user = context.result
      expect(user).to be_nil

      errors = context.errors
      expect(errors).not_to be_empty

      messages = errors[:user_authentication]
      expect(messages.first).to eq 'Invalid Credentials'
    end
  end

  context 'when user password does not match' do
    let!(:user) { create(:registered) }
    let!(:email) { user.email }
    let!(:password) { 'test' }

    it 'fails' do
      expect(context).to be_failure

      user = context.result
      expect(user).to be_nil

      errors = context.errors
      expect(errors).not_to be_empty

      messages = errors[:user_authentication]
      expect(messages.first).to eq 'Invalid Credentials'
    end
  end

  context 'when user match credentials' do
    let!(:user) { create(:registered) }
    let!(:email) { user.email }
    let!(:password) { user.password }

    it 'succeeds' do
      expect(context).to be_success

      info = context.result

      expect(info).not_to be_empty

      current_user = info[:user]
      type = info[:type]

      expect(current_user).not_to be_nil
      expect(current_user.email).to eq user.email
    end
  end
end