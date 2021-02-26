# frozen_string_literal: true

module Errors
  class ProviderNotFound < Errors::StandardError
    def initialize
      super(
        title: 'Provider not Found',
        status: 404,
        detail: Errors::Messages::PROVIDER_NOT_FOUND_ERROR_MESSAGE,
        source: { pointer: '/request/url/:id' }
      )
    end
  end
end
