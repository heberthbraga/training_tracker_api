# frozen_string_literal: true

module Api
  module V1
    module Token
      class CreateAccessFromRefresh
        prepend SimpleCommand

        def initialize(old_refresh_token)
          @old_refresh_token = old_refresh_token
        end

        def call
          token_expiry = Security::Token::Expiry.new

          payload = {
            sub: old_refresh_token[:sub],
            jti: Security::Token::Support.jti,
            iat: token_expiry.token_issued_at.to_i,
            exp: token_expiry.expire_access
          }

          Api::V1::Jwt::Encode payload
        end

        private

        attr_reader :old_refresh_token
      end
    end
  end
end
