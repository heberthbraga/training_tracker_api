class ValidationErrorsSerializer

  def initialize(record)
    @record = record
  end

  def serialize
    {
      message: "Validation Failed",
      errors: errors
    }
  end

private

  attr_reader :record

  def errors
    record.errors.details.map do |field, details|
      details.map do |error_details|
        ValidationErrorSerializer.new(record, field, error_details).serialize
      end
    end.flatten
  end
end