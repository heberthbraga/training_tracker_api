class Api::V1::MuscleGroupsController < ApplicationController
  before_action :set_muscle_group, only: [:show, :update, :destroy]

  api :GET, '/api/v1/muscle_groups', 'List all muscle groups'
  def index
    muscle_groups = policy_scope(MuscleGroup)

    render_response muscle_groups
  end

  api :POST, '/api/v1/muscle_groups', 'Creates a new muscle group'
  param :muscle_group, Hash, desc: 'Muscle group information', required: true do
    param :name, String, desc: 'Name of the muscle', required: true
  end
  def create
    muscle_group = policy_scope(MuscleGroup).new(muscle_group_params)

    muscle_group.save!

    render_response muscle_group
  end

  api :GET, '/api/v1/muscle_groups/:id', 'Show details of a muscle group'
  param :id, Integer, desc: 'id of the requested muscle group', required: true
  def show
    render_response @muscle_group
  end

  api :PUT, '/api/v1/muscle_groups/:id', 'Updates an existing muscle group'
  param :id, Integer, desc: 'id of the requested muscle group', required: true
  param :muscle_group, Hash, desc: 'Muscle group information', required: true do
    param :name, String, desc: 'Name of the muscle', required: true
  end
  def update
    @muscle_group.update!(muscle_group_params)

    render_response @muscle_group
  end

  api :DELETE, '/api/v1/muscle_groups/:id', 'Destroy an existing muscle group'
  param :id, Integer, desc: 'id of the muscle group', required: true
  def destroy
    @muscle_group.destroy!

    render_response @muscle_group
  end

private

  def set_muscle_group
    @muscle_group = policy_scope(MuscleGroup).find(params[:id])
  end

  def render_response entity
    render json: MuscleGroupSerializer.new(entity)
  end

  def muscle_group_params
    params.require(:muscle_group).permit(:name)
  end
end