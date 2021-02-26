# frozen_string_literal: true

module Errors
  class IdentityNotFound < Errors::StandardError
    def initialize
      super(
        title: 'Identity not Found',
        status: 404,
        detail: Errors::Messages::IDENTITY_NOT_FOUND_ERROR_MESSAGE,
        source: { pointer: '/request/url/:id' }
      )
    end
  end
end
