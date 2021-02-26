# frozen_string_literal: true

module Api
  module V1
    module Jwt
      class Decode
        prepend SimpleCommand

        def initialize(token, verify: true)
          @token = token
          @verify = verify
        end

        def call
          body = JWT.decode(token, Security::Token::Support.secret_decode, verify, { algorithm: 'RS256' })

          body ? (HashWithIndifferentAccess.new body[0]) : (return false)
        rescue JWT::DecodeError, JWT::VerificationError => e
          Rails.logger.error "=====> Api::V1::Jwt::Decode.error = #{e.inspect}"
          false
        end

        private

        attr_reader :token, :verify
      end
    end
  end
end
