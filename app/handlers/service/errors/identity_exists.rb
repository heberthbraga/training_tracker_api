# frozen_string_literal: true

module Service
  module Errors
    class IdentityExists < Errors::StandardError
      def initialize
        super(
          title: 'Identity Exists',
          status: 404,
          detail: Errors::Messages::IDENTITY_EXISTS_ERROR_MESSAGE,
          source: { pointer: '/request/url/:id' }
        )
      end
    end
  end
end
