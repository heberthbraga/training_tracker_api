class AuthStubSuccessCommand
  prepend SimpleCommand

  def initialize user
    @user = user
  end

  def call
    {
      user: @user,
      type: 'app'
    }
  end
end