# frozen_string_literal: true

module Api
  module V1
    module Authentication
      class Authenticate
        prepend SimpleCommand

        def initialize(authenticate_method)
          @authenticate_method = authenticate_method
        end

        def call
          authentication = authenticate_method

          if authentication.success?
            info = authentication.result
            user = info[:user]
            provider = info[:type]
            uuid = info[:uuid]

            Rails.logger.debug "Authenticating user #{user.id}"
            Rails.logger.debug "With provider: #{provider} and uuid: #{uuid}"

            Api::V1::Token::IssuerAccess.call({ user: user, provider: provider, uuid: uuid }).result
          end
        end

        private

        attr_reader :authenticate_method
      end
    end
  end
end
