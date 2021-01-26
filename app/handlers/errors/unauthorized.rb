class Errors::Unauthorized < Errors::StandardError
  def initialize
    super(
      title: "Unauthorized",
      status: 401,
      detail: Errors::Messages::UNAUTHOROZED_ERROR_MESSAGE
    )
  end
end