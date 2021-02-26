# frozen_string_literal: true

module Api
  module V1
    module Token
      class IssuerAccess
        prepend SimpleCommand

        def initialize(payload)
          @payload = payload
        end

        def call
          user = payload[:user]
          provider = payload[:provider]
          uuid = payload[:uuid]

          access_token = Api::V1::Token::CreateAccess.call(user, provider, uuid).result
          refresh_token = Api::V1::Token::RefreshAccess.call(user, provider, uuid).result

          {
            access_token: access_token,
            refresh_token: refresh_token
          }
        end

        private

        attr_reader :payload
      end
    end
  end
end
