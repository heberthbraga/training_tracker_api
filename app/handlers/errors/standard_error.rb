class Errors::StandardError < ::StandardError
  def initialize(title: nil, detail: nil, status: nil, source: {})
    @title = title || Errors::Messages::DEFAULT_TITLE_ERROR_MESSAGE
    @detail = detail || Errors::Messages::DEFAULT_DETAIL_ERROR_MESSAGE
    @status = status || 500
    @source = source.deep_stringify_keys
  end

  def to_h
    {
      status: status,
      title: title,
      detail: detail,
      source: source
    }
  end

  def serializable_hash
    to_h
  end

  def to_s
    to_h.to_s
  end

  attr_reader :title, :detail, :status, :source
end
