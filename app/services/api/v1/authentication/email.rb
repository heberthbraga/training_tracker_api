class Api::V1::Authentication::Email
  prepend SimpleCommand

  def initialize email, password
    @email = email
    @password = password
  end

  def call
    user = User.find_by(email: email.downcase)
    return { user: user, type: 'email' } if user && user.authenticate(password)
    
    errors.add(:user_authentication, 'Invalid Credentials')
    nil
  end

private

  attr_reader :email, :password
end