# frozen_string_literal: true

module Errors
  class Forbidden < Errors::StandardError
    def initialize
      super(
        title: 'Forbidden',
        status: 403,
        detail: Errors::Messages::UNAUTHOROZED_PUNDIT_ERROR_MESSAGE
      )
    end
  end
end
