# frozen_string_literal: true

module Security
  module Token
    class Support
      class << self
        def jti
          SecureRandom.hex
        end
  
        def secret_encode
          return if Rails.env.production?
  
          OpenSSL::PKey::RSA.new(File.read(Rails.root.join('keys/tracking-api.pem')))
        end
  
        def secret_decode
          return if Rails.env.production?
  
          OpenSSL::PKey::RSA.new(File.read(Rails.root.join('keys/tracking-api-public.pem')))
        end
      end
    end
  end
end
