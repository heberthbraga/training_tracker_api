# frozen_string_literal: true

module Api
  module V1
    module Authentication
      class AuthenticateByEmail
        prepend SimpleCommand

        def initialize(email, password)
          @email = email
          @password = password
        end

        def call
          user = User.find_by(email: email.downcase)
          return { user: user, type: 'email', uuid: nil } if user&.authenticate(password)

          errors.add(:user_authentication, 'Invalid Credentials')
          nil
        end

        private

        attr_reader :email, :password
      end
    end
  end
end
