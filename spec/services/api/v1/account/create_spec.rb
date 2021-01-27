require 'rails_helper'

describe Api::V1::Account::Create, type: :service do
  subject(:account_create_command) { described_class.call(account_params) }

  describe 'create email account' do
    context 'when there are user validation errors' do
      let(:account_params) { 
        {
          first_name: nil,
          last_name: nil,
          gender: nil,
          birthdate: nil,
          height: {
            value: nil,
            symbol: nil
          },
          weight: {
            value: nil,
            symbol: nil
          },
          identity: {
            provider: 'email',
            email: nil,
            passowrd: nil
          }
        } 
      }

      it 'fails' do
        response = account_create_command.result

        message = response[:message]
  
        expect(message).not_to be_empty
        expect(message).to eq Errors::Messages::VALIDATION_FAILED_ERROR_MESSAGE

        errors = response[:errors]
        
        expect(errors).not_to be_empty
        expect(errors[0][:field]).to eq 'password'
        expect(errors[0][:code]).to eq 'Cannot be blank'
        expect(errors[1][:field]).to eq 'email'
        expect(errors[1][:code]).to eq 'Cannot be blank'
        expect(errors[2][:field]).to eq 'email'
        expect(errors[2][:code]).to eq 'invalid'
        expect(errors[3][:field]).to eq 'first_name'
        expect(errors[3][:code]).to eq 'Cannot be blank'
        expect(errors[4][:field]).to eq 'last_name'
        expect(errors[4][:code]).to eq 'Cannot be blank'
        expect(errors[5][:field]).to eq 'gender'
        expect(errors[5][:code]).to eq 'Cannot be blank'
      end
    end

    context 'when account is created with success' do
      let(:account_params) { 
        {
          first_name: 'Foo',
          last_name: 'Bar',
          gender: 'male',
          birthdate: '2021/01/21',
          height: {
            value: 175,
            symbol: 'cm'
          },
          weight: {
            value: 75,
            symbol: 'kg'
          },
          identity: {
            provider: 'email',
            email: 'foo@example.com',
            password: 'test12345'
          }
        } 
      }

      before do
        create(:kilogram)
        create(:centimeter)
      end

      it 'returns the user info' do
        response = account_create_command.result

        expect(response).not_to be_nil

        user_hash = response.serializable_hash
        data = user_hash[:data]
        expect(data).not_to be_nil
        expect(data[:id]).not_to be_nil
        
        user_attributes = data[:attributes]

        expect(user_attributes[:first_name]).to eq 'Foo'
        expect(user_attributes[:last_name]).to eq 'Bar'
      end
    end

    context 'when identity already exists' do
      let(:account_params) { 
        {
          first_name: 'Foo',
          last_name: 'Bar',
          gender: 'male',
          birthdate: '2021/01/21',
          height: {
            value: 175,
            symbol: 'cm'
          },
          weight: {
            value: 75,
            symbol: 'kg'
          },
          identity: {
            provider: 'email',
            email: 'foo@example.com',
            password: 'test12345'
          }
        }  
      }

      before do
        create(:kilogram)
        create(:centimeter)

        user = create(:user, first_name: account_params[:first_name], last_name: account_params[:last_name], gender: account_params[:gender], birthdate: account_params[:birthdate] )
        create(:identity, provider: account_params[:identity][:provider], uuid: account_params[:identity][:email], access_token: nil, user: user)
      end

      it 'fails' do
        response = account_create_command.result

        expect(response).not_to be_nil

        errors = response[:errors]
        expect(errors).not_to be_empty
        expect(errors.first[:status]).to eq 404
        expect(errors.first[:detail]).to eq Errors::Messages::IDENTITY_EXISTS_ERROR_MESSAGE
      end
    end
  end
end