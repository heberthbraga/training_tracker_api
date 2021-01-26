class Api::V1::UsersController < ApplicationController

  api :GET, '/api/v1/users/details', 'Show details of the current user signed in'
  def details
    authorize current_user

    render json: UserSerializer.new(current_user, { include: [:training_sessions]})
  end
end