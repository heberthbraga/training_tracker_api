# frozen_string_literal: true

module Errors
  class NotFound < Errors::StandardError
    def initialize
      super(
        title: 'Record not Found',
        status: 404,
        detail: Errors::Messages::RECORD_NOT_FOUND_ERROR_MESSAGE,
        source: { pointer: '/request/url/:id' }
      )
    end
  end
end
