# frozen_string_literal: true

module Api
  module V1
    module Token
      class IssuerRefresh
        def initialize(old_refresh_token)
          @old_refresh_token = old_refresh_token
        end

        def call
          access_token = Api::V1::Token::CreateAccessFromRefresh.call(old_refresh_token).result
          refresh_token = Api::V1::Token::RefreshAccessFromOldToken.call(old_refresh_token).result

          {
            access_token: access_token,
            refresh_token: refresh_token
          }
        end

        private

        attr_reader :old_refresh_token
      end
    end
  end
end
