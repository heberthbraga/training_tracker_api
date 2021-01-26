require 'rails_helper'

describe Api::V1::MuscleGroupsController, type: :request do
  include_context 'authenticate_admin'

  describe '#index' do
    it 'returns a list of muscle groups' do
      create_list(:biceps, 5)

      get api_v1_muscle_groups_url

      response = json_response
  
      expect(response).not_to be_nil
      data = response[:data]
      
      expect(data).not_to be_nil
      expect(data).not_to be_empty
      expect(data.length).to eq 5
    end
  end

  describe '#show' do
    it 'returns an existing muscle group' do
      biceps = create(:biceps)

      get api_v1_muscle_group_url(biceps.id)

      response = json_response
    
      expect(response).not_to be_nil
      data = response[:data]

      expect(data).not_to be_nil
      attributes = data[:attributes]

      expect(attributes).not_to be_empty
      
      expect(attributes[:name]).not_to be_empty
      expect(attributes[:name]).to eq biceps.name
    end
  end

  describe '#create' do
    it 'returns a new muscle group' do
      name = 'Biceps 1'

      post api_v1_muscle_groups_url, params: {
        muscle_group: {
          name: name
        }
      }

      response = json_response
    
      expect(response).not_to be_nil
      data = response[:data]

      expect(data).not_to be_nil
      attributes = data[:attributes]

      expect(attributes).not_to be_empty
      
      expect(attributes[:name]).not_to be_empty
      expect(attributes[:name]).to eq name
    end
  end

  describe '#update' do
    it 'an existing muscle group' do
      biceps = create(:biceps)

      name = 'triceps'
      current_id = biceps.id
      
      put api_v1_muscle_group_url(current_id), params: {
        muscle_group: {
          name: name
        }
      }

      response = json_response
    
      expect(response).not_to be_nil
      data = response[:data]

      expect(data).not_to be_nil
      attributes = data[:attributes]

      expect(attributes).not_to be_empty
      
      expect(attributes[:name]).not_to be_empty
      expect(attributes[:name]).to eq name

      existing_muscle_group = MuscleGroup.find_by(id: current_id)
      expect(existing_muscle_group).not_to be_nil
      expect(existing_muscle_group.name).to eq name
    end
  end

  describe '#destroy' do
    it 'an existing muscle group' do
      biceps = create(:biceps)
      current_id = biceps.id

      delete api_v1_muscle_group_url(current_id)

      response = json_response
    
      expect(response).not_to be_nil
      data = response[:data]

      expect(data).not_to be_nil
      expect(data[:id]).not_to be_nil
      expect(data[:id]).to eq current_id.to_s

      existing_muscle_group = MuscleGroup.find_by(id: current_id)
      expect(existing_muscle_group).to be_nil
    end
  end
end