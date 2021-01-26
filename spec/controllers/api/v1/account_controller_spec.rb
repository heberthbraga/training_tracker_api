require 'rails_helper'

describe Api::V1::AccountController, type: :request do
  describe '#create' do
    context 'when identity is not found' do
      it 'raises exception' do
        post api_v1_account_create_url, params: {
          account: {
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
            }
          }
        }
  
        response = json_response
      
        expect(response).not_to be_nil

        errors = response[:errors]
        expect(errors).not_to be_empty
        expect(errors.first[:status]).to eq 404
        expect(errors.first[:detail]).to eq Errors::Messages::IDENTITY_NOT_FOUND_ERROR_MESSAGE
      end
    end

    context 'when identity provider is not found' do
      it 'raises exception' do
        post api_v1_account_create_url, params: {
          account: {
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
              provider: nil
            }
          }
        }
  
        response = json_response
      
        expect(response).not_to be_nil

        errors = response[:errors]
        expect(errors).not_to be_empty
        expect(errors.first[:status]).to eq 404
        expect(errors.first[:detail]).to eq Errors::Messages::PROVIDER_NOT_FOUND_ERROR_MESSAGE
      end
    end

    context 'when height is not provided' do
      it 'raises exception' do
        post api_v1_account_create_url, params: {
          account: {
            first_name: 'Foo',
            last_name: 'Bar',
            gender: 'male',
            birthdate: '2021/01/21',
            height: {
              
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
  
        response = json_response
      
        expect(response).not_to be_nil

        errors = response[:errors]
        expect(errors).not_to be_empty
        expect(errors.first[:status]).to eq 404
        expect(errors.first[:detail]).to eq Errors::Messages::HEIGHT_REQUIRED_ERROR_MESSAGE
      end
    end

    context 'when weight is not provided' do
      it 'raises exception' do
        post api_v1_account_create_url, params: {
          account: {
            first_name: 'Foo',
            last_name: 'Bar',
            gender: 'male',
            birthdate: '2021/01/21',
            height: {
              value: 176,
              symbol: 'cm'
            },
            weight: {
              
            },
            identity: {
              provider: 'email',
              email: 'foo@example.com',
              password: 'test12345'
            }
          }
        }
  
        response = json_response
      
        expect(response).not_to be_nil

        errors = response[:errors]
        expect(errors).not_to be_empty
        expect(errors.first[:status]).to eq 404
        expect(errors.first[:detail]).to eq Errors::Messages::WEIGHT_REQUIRED_ERROR_MESSAGE
      end
    end

    context 'when creating an account with success' do
      before do
        create(:kilogram)
        create(:centimeter)
      end

      it 'return the serialized user' do
        post api_v1_account_create_url, params: {
          account: {
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
  
        user_hash = json_response
      
        expect(user_hash).not_to be_nil

        data = user_hash[:data]
        expect(data).not_to be_nil
        expect(data[:id]).not_to be_nil
        
        user_attributes = data[:attributes]

        expect(user_attributes[:first_name]).to eq 'Foo'
        expect(user_attributes[:last_name]).to eq 'Bar'
      end
    end
  end
end