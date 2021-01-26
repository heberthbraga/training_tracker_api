class Api::V1::Authentication::Authorize
  prepend SimpleCommand

  def initialize token
    @token = token
  end

  def call
    user
  end

private
  attr_reader :token

  def user
    decoded_token = decode
    
    if decoded_token
      provider = decoded_token[:provider]
      uuid = decoded_token[:uuid]
      user_id = decoded_token[:user_id]

      identity = Identity.where(provider: decoded_token[:provider], uuid: decoded_token[:uuid], user_id: decoded_token[:user_id]).first
      @user ||= identity.user if identity
      @user || errors.add(:invalid_credentials, 'Wrong Credentials.') && nil
    else
      nil
    end
  end

  def decode
    if token.present?
      return Api::V1::Jwt::Decode.call(token).result
    else
      errors.add :invalid_token, 'Invalid Token.'
    end
    nil
  end
end