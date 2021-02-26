require 'rails_helper'

describe Api::V1::TrainingSessionsController, type: :request do
  include_context 'authenticate'

  describe '#create' do
    context 'new training session' do
      it 'succeeds' do
        name = 'test 1'
        deadline = '21/12/2020'

        post api_v1_training_sessions_url, params: { 
          training_session: {
            name: name,
            deadline: deadline
          }
        }, headers: @headers
  
        response = json_response
  
        expect(response).not_to be_nil
        data = response[:data]
  
        expect(data).not_to be_nil
        attributes = data[:attributes]
  
        expect(attributes).not_to be_empty
        
        expect(attributes[:name]).not_to be_empty
        expect(attributes[:name]).to eq name
        expect(attributes[:deadline]).not_to be_empty
        expect(attributes[:deadline]).to eq "2020-12-21T00:00:00.000Z"
      end

      it 'fails' do
        post api_v1_training_sessions_url, params: { 
          training_session: {
            name: nil,
            deadline: nil
          }
        }, headers: @headers
  
        response = json_response
  
        expect(response).not_to be_nil

        message = response[:message]

        expect(message).not_to be_empty
        expect(message).to eq Errors::Messages::VALIDATION_FAILED_ERROR_MESSAGE

        errors = response[:errors]
        expect(errors).not_to be_empty
        expect(errors[0][:field]).to eq 'name'
        expect(errors[0][:code]).to eq 'Cannot be blank'
        expect(errors[1][:field]).to eq 'deadline'
        expect(errors[1][:code]).to eq 'Cannot be blank'
      end
    end
  end

  describe '#show' do
    context 'training session' do
      it 'returns success' do
        @training_session = create(:training_session, owner: @user)

        get api_v1_training_session_url(@training_session.id), headers: @headers

        response = json_response
  
        expect(response).not_to be_nil
        data = response[:data]
  
        expect(data).not_to be_nil
        attributes = data[:attributes]
  
        expect(attributes).not_to be_empty
        
        expect(attributes[:name]).not_to be_empty
        expect(attributes[:name]).to eq @training_session.name
        expect(attributes[:deadline]).not_to be_empty
      end

      it 'fails' do
        get api_v1_training_session_url(1000), headers: @headers

        response = json_response
  
        expect(response).not_to be_nil

        errors = response[:errors]
        expect(errors).not_to be_empty
        expect(errors.first[:status]).to eq 404
        expect(errors.first[:title]).to eq Errors::Messages::RECORD_NOT_FOUND_ERROR_MESSAGE
      end
    end
  end

  describe '#update' do
    context 'existing training session' do
      it 'returns success' do
        @training_session = create(:training_session, owner: @user)

        put api_v1_training_session_url(@training_session.id), params: { 
          training_session: {
            name: 'test'
          }
        }, headers: @headers
  
        response = json_response
  
        expect(response).not_to be_nil
        data = response[:data]
  
        expect(data).not_to be_nil
        attributes = data[:attributes]
  
        expect(attributes).not_to be_empty
        
        expect(attributes[:name]).not_to be_empty
        expect(attributes[:name]).not_to eq @training_session.name
        expect(attributes[:name]).to eq 'test'
      end

      it 'fails' do
        @training_session = create(:training_session, owner: @user)

        put api_v1_training_session_url(@training_session.id), params: { 
          training_session: {
            name: ''
          }
        }, headers: @headers
  
        response = json_response
  
        expect(response).not_to be_nil

        message = response[:message]

        expect(message).not_to be_empty
        expect(message).to eq Errors::Messages::VALIDATION_FAILED_ERROR_MESSAGE

        errors = response[:errors]
        expect(errors).not_to be_empty
        expect(errors[0][:field]).to eq 'name'
        expect(errors[0][:code]).to eq 'Cannot be blank'
      end
    end
  end

  describe '#destroy' do
    context 'existing training session' do
      it 'returns success' do
        @training_session = create(:training_session, owner: @user)
        current_id = @training_session.id

        delete api_v1_training_session_url(current_id), headers: @headers

        response = json_response
  
        expect(response).not_to be_nil
        data = response[:data]
  
        expect(data).not_to be_nil
        expect(data[:id]).not_to be_nil
        expect(data[:id]).to eq current_id.to_s

        existing_training_session = TrainingSession.find_by(id: current_id)

        expect(existing_training_session).to be_nil
      end
    end
  end

  describe '#activites' do
    context 'fetching training session activities' do
      before do
        @training_session = create(:training_session, owner: @user)
        create_list(:activity_a, 6, training_session: @training_session)
      end

      it 'returns a list of activities' do
        get activities_api_v1_training_session_url(@training_session.id), headers: @headers

        response = json_response
  
        expect(response).not_to be_nil
        data = response[:data]
        
        expect(data).not_to be_nil
        expect(data).not_to be_empty
        expect(data.length).to eq 6
        expect(data[0][:id]).not_to be_nil
        expect(data[0][:type]).not_to be_nil
        expect(data[0][:type]).to eq 'activity'
      end
    end
  end
end