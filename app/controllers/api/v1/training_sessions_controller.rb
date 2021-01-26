class Api::V1::TrainingSessionsController < ApplicationController
  before_action :set_training_session, only: [:show, :update, :destroy, :activities]

  api :POST, '/api/v1/training_sessions', 'Creates a new training session'
  param :activity, Hash, desc: 'Activity information', required: true do
    param :name, String, desc: 'Name of the training', required: true
    param :deadline, String, desc: 'Target deadline of the training', required: true
  end
  def create
    training_session = TrainingSession.new(training_session_params)

    authorize training_session

    training_session.owner = current_user

    training_session.save!
    
    render_response training_session
  end

  api :GET, '/api/v1/training_sessions/:id', 'Show detials of the training'
  param :id, Integer, desc: 'id of the requested training', required: true
  def show
    render_response @training_session
  end

  api :PUT, '/api/v1/training_sessions/:id', 'Updates an existing training session'
  param :id, Integer, desc: 'id of the requested training', required: true
  param :activity, Hash, desc: 'Activity information', required: true do
    param :name, String, desc: 'Name of the training', required: true
    param :deadline, String, desc: 'Target deadline of the training', required: true
  end
  def update
    @training_session.update!(training_session_params)
    
    render_response @training_session
  end

  api :DELETE, '/api/v1/training_sessions/:id', 'Destroy an existing training'
  param :id, Integer, desc: 'id of the requested training', required: true
  def destroy
    @training_session.destroy!

    render_response @training_session
  end

  api :DELETE, '/api/v1/training_sessions/:id/activities', 'List all open activities of a training'
  param :id, Integer, desc: 'id of the requested training', required: true
  def activities
    render json: ActivitySerializer.new(@training_session.fetch_activities)
  end

private

  def render_response entity
    render json: TrainingSessionSerializer.new(entity)
  end

  def set_training_session
    @training_session = authorize TrainingSession.find(params[:id])
  end

  def training_session_params
    params.require(:training_session).permit(:name, :deadline)
  end
end