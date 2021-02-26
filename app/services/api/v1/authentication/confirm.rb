# frozen_string_literal: true

module Api
  module V1
    module Authentication
      class Confirm
        prepend SimpleCommand

        def initialize(decoded_token)
          @decoded_token = decoded_token
        end

        def call
          provider = decoded_token[:provider]
          uuid = decoded_token[:uuid]
          user_id = decoded_token[:sub]

          identity = Identity.where(provider: provider, uuid: uuid, user_id: user_id).first
          @user ||= identity.user if identity
        end

        private

        attr_reader :decoded_token
      end
    end
  end
end
