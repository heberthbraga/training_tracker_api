require 'rails_helper'

describe Api::V1::WorkoutExercisesController, type: :request do
  include_context 'authenticate'

  let!(:biceps) { create(:biceps) }
  let!(:training_session) { create(:training_session, owner: @user) }
  let!(:activity_a) { create(:activity_a, training_session: training_session) }

  describe '#create' do
    context 'new workout' do
      it 'returns success' do
        post api_v1_activity_workout_exercises_url(activity_a.id), params: {
          workout_exercise: {
            weights: 5,
            series: 3,
            repetitions: 10,
            exercise: {
              name: 'curl'
            },
            muscle: {
              name: biceps.name
            }
          }
        }, headers: @headers

        response = json_response
    
        expect(response).not_to be_nil

        data = response[:data]

        expect(data).not_to be_nil
        attributes = data[:attributes]
  
        expect(attributes).not_to be_empty
        
        expect(attributes[:activity_name]).not_to be_empty
        expect(attributes[:activity_name]).to eq activity_a.name
        expect(attributes[:exercise_name]).not_to be_empty
        expect(attributes[:exercise_name]).to eq 'curl'
        expect(attributes[:muscle_name]).not_to be_empty
        expect(attributes[:muscle_name]).to eq biceps.name
        expect(attributes[:weights]).not_to be_nil
        expect(attributes[:weights]).to eq 5
        expect(attributes[:series]).not_to be_nil
        expect(attributes[:series]).to eq 3
        expect(attributes[:repetitions]).not_to be_nil
        expect(attributes[:repetitions]).to eq 10
      end
    end
  end

  describe '#show' do
    context 'existing workout exercise' do
      it 'returns success' do
        workout = create(:workout, activity: activity_a)
        workout_exercise = create(:workout_exercise, workout: workout)

        get api_v1_workout_exercise_url(workout_exercise.id), headers: @headers

        response = json_response
    
        expect(response).not_to be_nil
        data = response[:data]
  
        expect(data).not_to be_nil
        attributes = data[:attributes]
  
        expect(attributes).not_to be_empty
        
        expect(attributes[:activity_name]).not_to be_empty
        expect(attributes[:activity_name]).to eq workout_exercise.workout.activity.name
        expect(attributes[:exercise_name]).not_to be_empty
        expect(attributes[:exercise_name]).to eq workout_exercise.exercise.name
        expect(attributes[:muscle_name]).not_to be_empty
        expect(attributes[:muscle_name]).to eq workout_exercise.muscle_group.name
        expect(attributes[:weights]).not_to be_nil
        expect(attributes[:weights]).to eq workout_exercise.weights
        expect(attributes[:series]).not_to be_nil
        expect(attributes[:series]).to eq workout_exercise.series
        expect(attributes[:repetitions]).not_to be_nil
        expect(attributes[:repetitions]).to eq workout_exercise.repetitions
      end
    end
  end

  describe '#update' do
    context 'existing workout exercise' do
      it 'returns success' do
        workout = create(:workout, activity: activity_a)
        workout_exercise = create(:workout_exercise, workout: workout)

        weights = 15
        series = 4
        repetitions = 8

        put api_v1_workout_exercise_url(workout_exercise.id), params: {
          workout_exercise: {
            weights: weights,
            series: series,
            repetitions: repetitions
          }
        }, headers: @headers

        response = json_response
    
        expect(response).not_to be_nil
        data = response[:data]
  
        expect(data).not_to be_nil
        attributes = data[:attributes]
  
        expect(attributes).not_to be_empty
        
        expect(attributes[:weights]).not_to be_nil
        expect(attributes[:weights]).to eq weights
        expect(attributes[:series]).not_to be_nil
        expect(attributes[:series]).to eq series
        expect(attributes[:repetitions]).not_to be_nil
        expect(attributes[:repetitions]).to eq repetitions

        existing_workout_session = WorkoutExercise.find_by(id: workout_exercise.id)
        expect(existing_workout_session).not_to be_nil
        expect(existing_workout_session.weights).to eq weights
      end
    end
  end

  describe '#destroy' do
    context 'existing workout exercise' do
      it 'returns success' do
        workout = create(:workout, activity: activity_a)
        workout_exercise = create(:workout_exercise, workout: workout)
        current_id = workout_exercise.id

        delete api_v1_workout_exercise_url(current_id), headers: @headers

        response = json_response

        data = response[:data]
  
        expect(data).not_to be_nil
        expect(data[:id]).not_to be_nil
        expect(data[:id]).to eq current_id.to_s

        existing_workout_session = WorkoutExercise.find_by(id: workout_exercise.id)

        expect(existing_workout_session).to be_nil
      end
    end
  end 
end