require 'rails_helper'

describe Api::V1::ActivitiesController, type: :request do
  describe '#index' do
    context 'admin' do
      include_context 'authenticate_admin'

      before do
        training_session = create(:training_session, owner: @user)
        create_list(:activity_a, 6, training_session: training_session)
      end

      it 'returns a list of activities' do
        get api_v1_activities_url, headers: @headers

        response = json_response
  
        expect(response).not_to be_nil
        data = response[:data]
        
        expect(data).not_to be_nil
        expect(data).not_to be_empty
        expect(data.length).to eq 6
      end
    end

    context 'registered user' do
      include_context 'authenticate'

      it 'returns a list of activities fail' do
        get api_v1_activities_url, headers: @headers

        response = json_response
  
        expect(response).not_to be_nil
        
        errors = response[:errors]
        expect(errors).not_to be_empty
        expect(errors.first[:status]).to eq 403
        expect(errors.first[:title]).to eq 'Forbidden'
        expect(errors.first[:detail]).to eq Errors::Messages::UNAUTHOROZED_PUNDIT_ERROR_MESSAGE
      end
    end
  end

  describe 'owner' do
    include_context 'authenticate'
    let!(:training_session) { training_session = create(:training_session, owner: @user) }

    describe 'create' do
      context 'new activity' do
        let(:create_url) { api_v1_training_session_activities_url(training_session.id) }

        it 'returns success' do
          name = 'Training A'
          activity_type = 'workout'
          phases = 20
          duration = 3600
  
          post create_url, params: { 
            activity: {
              name: name,
              activity_type: activity_type,
              phases: phases,
              timer: {
                duration: duration
              }
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
          expect(attributes[:activity_type]).not_to be_empty
          expect(attributes[:activity_type]).to eq activity_type
          expect(attributes[:phases]).not_to be_nil
          expect(attributes[:phases]).to eq phases
          expect(attributes[:duration]).not_to be_nil
          expect(attributes[:duration]).to eq duration
        end
  
        it 'fails' do
          post create_url, params: { 
            activity: {
              name: nil,
              activity_type: nil,
              phases: nil, 
              timer: {
                duration: nil
              }
            }
          }, headers: @headers
    
          response = json_response
    
          expect(response).not_to be_nil
  
          message = response[:message]
  
          expect(message).not_to be_empty
          expect(message).to eq Errors::Messages::VALIDATION_FAILED_ERROR_MESSAGE
  
          errors = response[:errors]
          
          expect(errors).not_to be_empty
          expect(errors[0][:field]).to eq 'timer.duration'
          expect(errors[0][:code]).to eq 'Cannot be blank'
          expect(errors[1][:field]).to eq 'activity_type'
          expect(errors[1][:code]).to eq 'Cannot be blank'
          expect(errors[2][:field]).to eq 'name'
          expect(errors[2][:code]).to eq 'Cannot be blank'
          expect(errors[3][:field]).to eq 'phases'
          expect(errors[3][:code]).to eq 'Cannot be blank'
        end
      end
    end
  
    describe '#show' do
      context 'activity' do
        it 'returns success' do
          activity_a = create(:activity_a, training_session: training_session)
  
          get api_v1_activity_url(activity_a.id), headers: @headers
  
          response = json_response
    
          expect(response).not_to be_nil
          data = response[:data]
    
          expect(data).not_to be_nil
          attributes = data[:attributes]
    
          expect(attributes).not_to be_empty
          
          expect(attributes[:name]).not_to be_empty
          expect(attributes[:name]).to eq activity_a.name
          expect(attributes[:activity_type]).not_to be_empty
          expect(attributes[:activity_type]).to eq activity_a.activity_type
          expect(attributes[:phases]).not_to be_nil
          expect(attributes[:phases]).to eq activity_a.phases
          expect(attributes[:duration]).not_to be_nil
          expect(attributes[:duration]).to eq activity_a.timer.duration
        end
  
        it 'fails' do
          get api_v1_activity_url(1000), headers: @headers
  
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
      context 'existing activity' do
        let!(:activity_a) { create(:activity_a, training_session: training_session) }

        it 'returns success' do
          name = 'Training A.1'
          duration = 4080
  
          put api_v1_activity_url(activity_a.id), params: { 
            activity: {
              name: name,
              timer: {
                duration: duration
              }
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
          expect(attributes[:duration]).not_to be_nil
          expect(attributes[:duration]).to eq duration

          existing_activity_a = Activity.find_by(id: activity_a.id)
          expect(existing_activity_a).not_to be_nil
          expect(existing_activity_a.name).to eq name
          expect(existing_activity_a.timer.duration).to eq duration
        end

        it 'fails' do
          put api_v1_activity_url(activity_a.id), params: { 
            activity: {
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
      context 'existing activity' do
        it 'returns success' do
          activity_a = create(:activity_a, training_session: training_session)
          current_id = activity_a.id
  
          delete api_v1_activity_url(current_id), headers: @headers
  
          response = json_response
    
          expect(response).not_to be_nil
          data = response[:data]
    
          expect(data).not_to be_nil
          expect(data[:id]).not_to be_nil
          expect(data[:id]).to eq current_id.to_s
  
          existing_activity_a = Activity.find_by(id: current_id)
  
          expect(existing_activity_a).to be_nil
        end
      end
    end
  
    describe '#finish' do
      context 'existing activity' do
        it 'returns success' do
          activity_a = create(:activity_a, training_session: training_session)
          current_id = activity_a.id

          put finish_api_v1_activity_url(current_id), params: {
            complete: true
          }, headers: @headers

          response = json_response

          expect(response).not_to be_nil
          data = response[:data]
    
          expect(data).not_to be_nil
          attributes = data[:attributes]
    
          expect(attributes).not_to be_empty
          
          expect(attributes[:completed]).not_to be_nil
          expect(attributes[:completed]).to eq true
          
          existing_activity_a = Activity.find_by(id: current_id)
  
          expect(existing_activity_a).not_to be_nil
          expect(existing_activity_a.completed).to eq true
        end
      end
    end
  end
end