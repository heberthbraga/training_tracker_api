# frozen_string_literal: true

module Api
  module V1
    module Authentication
      class Authorize
        prepend SimpleCommand

        def initialize(headers)
          @token = headers['Authorization']&.split('Bearer ')&.last
        end

        def call
          user
        end

        private

        attr_reader :token

        def user
          decoded_token = decode

          if decoded_token
            @user = Api::V1::Authentication::Confirm.call(decoded_token).result
            @user || errors.add(:invalid_credentials, 'Wrong Credentials.') && nil
          end
        end

        def decode
          return Api::V1::Jwt::Decode.call(token).result if token.present?

          errors.add :invalid_token, 'Invalid Token.'

          nil
        end
      end
    end
  end
end
