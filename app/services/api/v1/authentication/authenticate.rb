class Api::V1::Authentication::Authenticate
  prepend SimpleCommand

  def initialize authenticate_method
    @authenticate_method = authenticate_method
  end

  def call
    authentication = authenticate_method
    
    if authentication.success?
      info = authentication.result
      user = info[:user]

      Rails.logger.debug "Authenticating user #{user.id}"

      jwt_encoded_command = Api::V1::Jwt::Encode.call({ provider: info[:type], user_id: user.id }, 4.hours.from_now)

      user_info = Hash.new
      user_info[:token] = jwt_encoded_command.result
      user_info[:user_id] = user.id
      user_info[:first_name] = user.first_name
      user_info[:last_name] = user.last_name

      return user_info
    else
      nil
    end
  end

private

  attr_reader :authenticate_method
end