class Errors::Forbidden < Errors::StandardError
  def initialize
    super(
      title: 'Forbidden',
      status: 403,
      detail: Errors::Messages::UNAUTHOROZED_PUNDIT_ERROR_MESSAGE
    )
  end
end