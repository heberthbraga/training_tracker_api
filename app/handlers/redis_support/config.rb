# frozen_string_literal: true

module RedisSupport
  class Config
    def initialize
      @url = "redis://:#{ENV['REDIS_PASSWORD']}@#{ENV['REDIS_HOST']}" \
      ":#{ENV['REDIS_PORT']}/#{ENV['REDIS_DATABASE']}"
    end

    def connect
      Redis.new(url: url)
    end

    private

    attr_reader :url
  end
end
