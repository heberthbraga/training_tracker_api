# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      api :GET, '/api/v1/users/details', 'Show details of the current user signed in'
      def details
        authorize current_user

        render json: UserSerializer.new(current_user, { include: [:training_sessions] })
      end
    end
  end
end
