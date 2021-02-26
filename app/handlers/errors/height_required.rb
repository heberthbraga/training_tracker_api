# frozen_string_literal: true

module Errors
  class HeightRequired < Errors::StandardError
    def initialize
      super(
        title: 'Height Required',
        status: 404,
        detail: Errors::Messages::HEIGHT_REQUIRED_ERROR_MESSAGE,
        source: { pointer: '/request/url/:id' }
      )
    end
  end
end
