class Api::V1::Jwt::Encode
  prepend SimpleCommand

  JWT_SECRET = Rails.application.secrets.secret_key_base

  def initialize payload, exp = 24.hours.from_now
    @payload = payload
    @exp = exp
  end

  def call
    payload[:exp] = exp.to_i
    JWT.encode(payload, JWT_SECRET)
  end

private

  attr_reader :payload, :exp
end