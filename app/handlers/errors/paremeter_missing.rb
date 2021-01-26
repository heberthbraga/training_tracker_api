class Errors::ParemeterMissing < Errors::StandardError
  def initialize
    super(
      title: "Parameter Missing",
      status: 400,
      detail: Errors::Messages::PARAMETER_MISSING_ERROR_MESSAGE,
      source: { pointer: "/request/url/:id" }
    )
  end
end