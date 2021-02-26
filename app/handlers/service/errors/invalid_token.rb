# frozen_string_literal: true

module Service
  module Errors
    class InvalidToken < Errors::StandardError
      def initialize
        super(
          title: 'Token not Found',
          status: 404,
          detail: Errors::Messages::TOKEN_NOT_FOUND_ERROR_MESSAGE,
          source: { pointer: '/request/url/:id' }
        )
      end
    end
  end
end
