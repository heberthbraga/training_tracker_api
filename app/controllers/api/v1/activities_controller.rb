class Api::V1::ActivitiesController < ApplicationController
  before_action :set_training_session, only: [:create] 
  before_action :set_activity, only: [:show, :update, :destroy, :finish]

  api :GET, '/api/v1/activities', 'List all activites'
  def index
    activities = policy_scope(Activity)

    render_response activities
  end

  api :POST, '/api/v1/training_sessions/:training_session_id/activities', 'Creates a new activity'
  param :training_session_id, Integer, desc: 'id of the training session which will own the activity', required: true
  param :activity, Hash, desc: 'Activity information', required: true do
    param :name, String, desc: 'Name of the acitivity', required: true
    param :phases, Integer, desc: 'Phases of the acitivity', required: true
    param :timer, Hash, desc: 'Timer information', required: true do
      param :duration, Integer, desc: 'Duration of the activity', required: true
    end
  end
  def create
    activity = Activity.new(activity_params)
    activity.training_session = @training_session

    activity.save!

    render_response activity
  end

  api :GET, '/api/v1/activities/:id', 'Show detials of an activity'
  param :id, Integer, desc: 'id of the requested activity', required: true
  def show
    render_response @activity
  end

  api :PUT, '/api/v1/activities/:id', 'Update a new activity'
  param :id, Integer, desc: 'id of the requested activity', required: true
  param :activity, Hash, desc: 'Activity information', required: true do
    param :name, String, desc: 'Name of the acitivity', required: true
    param :phases, Integer, desc: 'Phases of the acitivity', required: true
    param :timer, Hash, desc: 'Timer information', required: true do
      param :duration, Integer, desc: 'Duration of the activity', required: true
    end
  end
  def update
    @activity.update!(activity_params)

    render_response @activity
  end

  api :DELETE, '/api/v1/activities/:id', 'Destroy an existing activity'
  param :id, Integer, desc: 'id of the requested activity', required: true
  def destroy
    @activity.destroy!

    render_response @activity
  end

  api :PUT, '/api/v1/activities/:id/finish', 'Terminate an existing activity'
  param :id, Integer, desc: 'id of the requested activity', required: true
  param :complete, [true, false], desc: 'Options to terminate or not an activity', required: true
  def finish
    @activity.update(completed: params[:complete])

    render_response @activity
  end

private
  def render_response entity
    render json: ActivitySerializer.new(entity)
  end

  def activity_params
    current_activity_params = params.require(:activity).permit(
      :name, 
      :activity_type, 
      :phases, 
      { 
        timer: [:duration] 
      }
    )

    if current_activity_params[:timer].present?
      current_activity_params[:timer_attributes] = current_activity_params.delete :timer
    end
    
    current_activity_params.permit!
  end

  def set_activity
    @activity = authorize Activity.find(params[:id])
  end

  def set_training_session
    @training_session = authorize TrainingSession.find(params[:training_session_id])
  end
end