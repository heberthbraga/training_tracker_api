# frozen_string_literal: true

module Errors
  class Messages
    VALIDATION_FAILED_ERROR_MESSAGE = 'Validation Failed'
    RECORD_NOT_FOUND_ERROR_MESSAGE = 'Record not Found'
    UNAUTHOROZED_PUNDIT_ERROR_MESSAGE = 'You are not authorized to perform this action.'
    UNAUTHOROZED_ERROR_MESSAGE = 'You are not authorized.'
    PARAMETER_MISSING_ERROR_MESSAGE = 'param is missing or the value is empty.'
    DEFAULT_TITLE_ERROR_MESSAGE = 'Something went wrong.'
    DEFAULT_DETAIL_ERROR_MESSAGE = 'We encountered unexpected error, but our developers had been already notified about it.'
    IDENTITY_NOT_FOUND_ERROR_MESSAGE = 'You must provide a valid identity'
    PROVIDER_NOT_FOUND_ERROR_MESSAGE = 'You must provide a valid provider'
    IDENTITY_EXISTS_ERROR_MESSAGE = 'You already have an account for these credentials'
    HEIGHT_REQUIRED_ERROR_MESSAGE = 'Height value and symbol are required'
    WEIGHT_REQUIRED_ERROR_MESSAGE = 'Weight value and symbol are required'
    TOKEN_NOT_FOUND_ERROR_MESSAGE = 'Token not found or is invalid'
  end
end
