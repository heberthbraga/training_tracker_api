# frozen_string_literal: true

module Errors
  class StandardError < ::StandardError
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

    delegate :to_s, to: :to_h

    attr_reader :title, :detail, :status, :source
  end
end
