class AuthStubFailureCommand
  prepend SimpleCommand

  def call
    errors.add(:fail, 'failed')
    nil
  end
end