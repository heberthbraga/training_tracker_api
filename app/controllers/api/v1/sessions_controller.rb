# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authorize_request, only: :email

      api :POST, '/api/v1/sessions/email', 'Sign in a registered user by email/password'
      param :email, String, desc: 'User email', required: true
      param :password, String, desc: 'User password', required: true
      def email
        email = params[:email]
        password = params[:password]

        if email && password
          email_auth = Api::V1::Authentication::AuthenticateByEmail.call(email, password)
          access_info = Api::V1::Authentication::Authenticate.call(email_auth).result

          if access_info.present?
            render json: access_info
          else
            render json: { error: 'Failed to authenticate', status: 'authentication_failed',
                           code: 422 }
          end
        else
          render json: { error: 'Specify email address and password', status: 'incorrect_credentials',
                         code: 422 }
        end
      end
    end
  end
end
