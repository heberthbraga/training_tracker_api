class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorize_request, only: :email

  api :DELETE, '/api/v1/sessions/invalidate', 'Invalidates an existing jwt token'
  def invalidate
    if current_user
      cookies.delete(:jwt)
      render json: { status: 'ok', code: 200 }
    end
  end

  api :POST, '/api/v1/sessions/email', 'Sign in a registered user by email/password'
  param :email, String, desc: 'User email', required: true
  param :password, String, desc: 'User password', required: true
  def email
    email = params[:email]
    password = params[:password]

    if email && password
      email_auth = Api::V1::Authentication::Email.call(email, password)
      user_info = Api::V1::Authentication::Authenticate.call(email_auth).result

      if user_info.present?
        cookies.signed[:jwt] = { value: user_info[:token], httponly: true }
        
        render json: {
          user_id: user_info[:user_id],
          name: "#{user_info[:first_name]} #{user_info[:last_name]}"
        }
      else
        render json: { error: 'Failed to authenticate', status: 'authentication_failed', code: 422 }
      end
    else
      render json: { error: 'Specify email address and password', status: 'incorrect_credentials', code: 422  }
    end
  end
end