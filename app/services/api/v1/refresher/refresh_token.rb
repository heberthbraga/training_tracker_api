# frozen_string_literal: true

module Api
  module V1
    module Refresher
      class RefreshToken
        prepend SimpleCommand

        def initialize(refresh_token)
          @refresh_token = refresh_token
          @token_whitelist = Security::Token::Whitelist.new
        end

        def call
          return ErrorSerializer.new(Service::Errors::InvalidToken.new).to_h if refresh_token.blank?

          decoded_token = Api::V1::Jwt::Decode.call(refresh_token).result

          if token_whitelist.valid?(decoded_token)
            issuer_refresh(decoded_token)
          elsif token_whitelist.refresh?(decoded_token)
            issuer_access(decoded_token)
          end
        end

        private

        attr_reader :refresh_token, :token_whitelist

        def issuer_refresh(decoded_token)
          token_whitelist.remove decoded_token

          Api::V1::Token::IssuerRefresh.call(decoded_token).result
        end

        def issuer_access(decoded_token)
          user = Api::V1::Authentication::Confirm.call(decoded_token).result
          return ErrorSerializer.new(Service::Errors::InvalidToken.new).to_h if user.blank?

          token_whitelist.remove decoded_token
          Api::V1::Token::IssuerAccess.call(user).result
        end
      end
    end
  end
end
