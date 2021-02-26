# frozen_string_literal: true

module Api
  module V1
    class WorkoutExercisesController < ApplicationController
      before_action :set_activity, only: [:create]
      before_action :set_workout_exercise, only: %i[show update destroy]

      api :POST, '/api/v1/activities/:activity_id/workout_exercises',
          'Creates a new workout exercise'
      param :activity_id, Integer, desc: 'id of the activity which will own the workout training',
                                   required: true
      param :workout_exercise, Hash, desc: 'Workout Exercise information', required: true do
        param :weights, Integer, desc: 'Exercise weights', required: true
        param :series, Integer, desc: 'Number of series of the exercise', required: true
        param :repetitions, Hash, desc: 'Number of weights of the exercise', required: true
        param :exercise, Hash, desc: 'Exercise information', required: true do
          param :name, Integer, desc: 'Name of the exercise', required: true
        end
        param :muscle, Hash, desc: 'Muscle Group information', required: true do
          param :name, Integer, desc: 'Name of the muscle group required for the exercise',
                                required: true
        end
      end
      def create
        workout_exercise = WorkoutExercise.new(workout_exercise_params)

        workout = Workout.new
        workout.activity = @activity

        workout_exercise.workout = workout

        workout_exercise.save!

        render_response workout_exercise
      end

      api :GET, '/api/v1/workout_exercises/:id', 'Show detials of the workout exercise'
      param :id, Integer, desc: 'id of the requested workout exercise', required: true
      def show
        render_response @workout_exercise
      end

      api :PUT, '/api/v1/workout_exercises/:id', 'Updates an existing workout exercise'
      param :id, Integer, desc: 'id of the workout exercise', required: true
      param :workout_exercise, Hash, desc: 'Workout Exercise information', required: true do
        param :weights, Integer, desc: 'Exercise weights', required: true
        param :series, Integer, desc: 'Number of series of the exercise', required: true
        param :repetitions, Hash, desc: 'Number of weights of the exercise', required: true
        param :exercise, Hash, desc: 'Exercise information', required: true do
          param :name, Integer, desc: 'Name of the exercise', required: true
        end
        param :muscle, Hash, desc: 'Muscle Group information', required: true do
          param :name, Integer, desc: 'Name of the muscle group required for the exercise',
                                required: true
        end
      end
      def update
        @workout_exercise.update!(workout_exercise_params)

        render_response @workout_exercise
      end

      api :DELETE, '/api/v1/workout_exercises/:id', 'Destroy an existing workout exercise'
      param :id, Integer, desc: 'id of the workout exercise', required: true
      def destroy
        @workout_exercise.destroy!

        render_response @workout_exercise
      end

      private

      def render_response(entity)
        render json: WorkoutExerciseSerializer.new(entity)
      end

      def workout_exercise_params
        current_params = params.require(:workout_exercise).permit(
          :weights,
          :series,
          :repetitions,
          {
            exercise: [:name]
          },
          {
            muscle: [:name]
          }
        )

        if current_params[:exercise].present?
          current_params[:exercise_attributes] = current_params.delete :exercise
        end

        if current_params[:muscle].present?
          current_params[:muscle_group_attributes] = current_params.delete :muscle
        end

        current_params.permit!
      end

      def set_activity
        @activity = authorize Activity.find(params[:activity_id])
      end

      def set_workout_exercise
        @workout_exercise = authorize WorkoutExercise.find(params[:id])
      end
    end
  end
end
