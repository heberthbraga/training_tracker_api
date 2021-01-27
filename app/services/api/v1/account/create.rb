class Api::V1::Account::Create
  prepend SimpleCommand

  def initialize account_params
    @account_params = account_params
  end

  def call
    user = User.new
    user.first_name = account_params[:first_name]
    user.last_name = account_params[:last_name]
    user.gender = account_params[:gender]
    user.birthdate = account_params[:birthdate]

    height = account_params[:height]
    user.height = Height.new(value: height[:value], system_of_unit: SystemOfUnit.find_by_symbol(height[:symbol]))
    weight = account_params[:weight]
    user.weight = Weight.new(value: weight[:value], system_of_unit: SystemOfUnit.find_by_symbol(weight[:symbol]))

    identity = account_params[:identity]
    provider = identity[:provider]

    uuid = nil
    access_token = nil

    if provider === 'email'
      user.email = identity[:email]
      user.password = identity[:password]
      uuid = identity[:email]
    else
      # other sign up methods
    end

    identity = Identity.find_by(provider: provider, uuid: uuid, access_token: access_token)

    return ErrorSerializer.new(Service::Errors::IdentityExists.new).to_h if identity.present?

    if user.save
      user.add_role(:registered)

      Identity.create(provider: provider, user: user, uuid: uuid, access_token: access_token)

      return UserSerializer.new(user)
    else
      return ValidationErrorsSerializer.new(user).serialize
    end
  end

private

  attr_reader :account_params
end