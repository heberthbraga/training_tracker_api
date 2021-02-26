# frozen_string_literal: true

module Errors
  class WeightRequired < Errors::StandardError
    def initialize
      super(
        title: 'Weight Required',
        status: 404,
        detail: Errors::Messages::WEIGHT_REQUIRED_ERROR_MESSAGE,
        source: { pointer: '/request/url/:id' }
      )
    end
  end
end
