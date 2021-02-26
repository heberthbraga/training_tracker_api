require 'rails_helper'

describe Api::V1::UsersController, type: :request do
  context 'when not authorized to request the details' do
    it 'returns unauthorized status' do
      get details_api_v1_users_url

      response = json_response
      
      expect(response).not_to be_nil

      errors = response[:errors]
      expect(errors).not_to be_empty
      expect(errors.first[:status]).to eq 401
      expect(errors.first[:title]).to eq 'Unauthorized'
      expect(errors.first[:detail]).to eq Errors::Messages::UNAUTHOROZED_ERROR_MESSAGE
    end
  end

  context 'when authorized to request the details' do
    include_context 'authenticate'

    it 'returns the user details' do
      get details_api_v1_users_url, headers: @headers

      response = json_response

      expect(response).not_to be_nil
      data = response[:data]

      expect(data).not_to be_nil
      id = data[:id]
      attributes = data[:attributes]

      expect(id).not_to be_nil
      expect(attributes).not_to be_empty
      expect(id).to eq @user.id.to_s
      expect(attributes[:first_name]).to eq @user.first_name
      expect(attributes[:last_name]).to eq @user.last_name
    end

    it 'returns the user details including training sessions' do
      training_session = create(:training_session, owner: @user)

      get details_api_v1_users_url, headers: @headers

      response = json_response

      expect(response).not_to be_nil
      data = response[:data]

      expect(data).not_to be_nil

      id = data[:id]
      attributes = data[:attributes]

      expect(id).not_to be_nil
      expect(attributes).not_to be_empty
      expect(id).to eq @user.id.to_s
      expect(attributes[:first_name]).to eq @user.first_name
      expect(attributes[:last_name]).to eq @user.last_name

      included = response[:included]
      expect(included).not_to be_nil
      expect(included[0][:id]).to eq training_session.id.to_s
      expect(included[0][:type]).to eq 'training_session'

      included_attributes = included[0][:attributes]
      expect(included_attributes).not_to be_empty
    end
  end
end