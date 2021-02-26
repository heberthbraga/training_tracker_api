# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit
  include ErrorHandler

  respond_to? :json

  before_action :set_default_response_format
  before_action :authorize_request

  attr_reader :current_user

  private

  def authorize_request
    authorize_command = Api::V1::Authentication::Authorize.call(request.headers)

    @current_user = authorize_command.result

    p @current_user

    if @current_user.blank?
      Rails.logger.error "AuthorizationError => #{authorize_command.errors}"
      raise Errors::Unauthorized
    end
  end

  def set_default_response_format
    request.format = :json
  end
end
