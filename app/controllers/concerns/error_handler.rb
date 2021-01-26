module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from Pundit::NotAuthorizedError, with: :render_pundit_not_authorized
    rescue_from ActionController::ParameterMissing, with: :render_parameter_missing
    rescue_from Errors::Unauthorized, with: :render_unauthorized_error
    rescue_from Errors::IdentityNotFound, with: :render_identity_not_found_error
    rescue_from Errors::ProviderNotFound, with: :render_provider_not_found_error
    rescue_from Errors::HeightRequired, with: :render_height_required_error
    rescue_from Errors::WeightRequired, with: :render_weight_required_error
  end

  def render_unprocessable_entity_response exception
    render json: ValidationErrorsSerializer.new(exception.record).serialize, status: :unprocessable_entity
  end

  def render_not_found_response exception
    render_error Errors::NotFound.new
  end

  def render_pundit_not_authorized exception
    render_error Errors::Forbidden.new
  end

  def render_parameter_missing exception
    render_error Errors::ParemeterMissing.new
  end

  def render_unauthorized_error exception
    render_error Errors::Unauthorized.new
  end

  def render_identity_not_found_error exception
    render_error Errors::IdentityNotFound.new
  end

  def render_provider_not_found_error exception
    render_error Errors::ProviderNotFound.new
  end

  def render_height_required_error exception
    render_error Errors::HeightRequired.new
  end

  def render_weight_required_error exception
    render_error Errors::WeightRequired.new
  end

private

  def render_error exception
    render json: ErrorSerializer.new(exception), status: exception.status
  end
end