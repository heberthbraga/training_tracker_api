class Api::V1::Jwt::Decode
  prepend SimpleCommand

  JWT_SECRET = Rails.application.secrets.secret_key_base

  def initialize token
    @token = token
  end

  def call
    begin
      body = JWT.decode(token, JWT_SECRET)
      
      if body then HashWithIndifferentAccess.new body[0] else return false end

      rescue JWT::ExpiredSignature, JWT::VerificationError => e
        Rails.logger.error "=====> Api::V1::Jwt::Decode.error = #{e.inspect}"
        return false
      rescue JWT::DecodeError, JWT::VerificationError => e
        Rails.logger.error "=====> Api::V1::Jwt::Decode.error = #{e.inspect}"
        return false
      end
  end

private 

  attr_reader :token
end