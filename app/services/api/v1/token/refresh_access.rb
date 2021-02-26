# frozen_string_literal: true

module Api
  module V1
    module Token
      class RefreshAccess
        prepend SimpleCommand

        def initialize(user, provider, uuid)
          @user = user
          @provider = provider
          @uuid = uuid
        end

        def call
          token_expiry = Security::Token::Expiry.new
          payload = {
            provider: provider,
            uuid: uuid,
            sub: user.id,
            jti: Security::Token::Support.jti,
            iat: token_expiry.token_issued_at.to_i,
            exp: token_expiry.expire_refresh
          }
          Security::Token::Whitelist.new.add(payload)
          Api::V1::Jwt::Encode.call(payload).result
        end

        private

        attr_reader :user, :provider, :uuid
      end
    end
  end
end
