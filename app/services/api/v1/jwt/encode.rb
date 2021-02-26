# frozen_string_literal: true

module Api
  module V1
    module Jwt
      class Encode
        prepend SimpleCommand

        def initialize(payload)
          @payload = payload
        end

        def call
          JWT.encode(payload, Security::Token::Support.secret_encode, 'RS256')
        end

        private

        attr_reader :payload

        def secret; end
      end
    end
  end
end
