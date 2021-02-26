# frozen_string_literal: true

module Security
  module Token
    class Whitelist
      def initialize
        @redis_instance = Rails.env.test? ? Redis.new : RedisSupport::Config.new.connect
      end
    
      def add(decoded_token)
        @redis_instance.set "#{decoded_token[:provider]}:#{decoded_token[:sub]}:#{decoded_token[:jti]}", 'VALID'
      end
    
      def valid?(refresh_token)
        get(refresh_token) == 'VALID'
      end
    
      def refresh?(refresh_token)
        get(refresh_token) == 'REFRESH'
      end
    
      def remove(decoded_token)
        redis_instance.del "#{decoded_token[:provider]}:#{decoded_token[:sub]}:#{decoded_token[:jti]}"
      end
    
      def revoke(provider, user_id)
        keys = redis_instance.keys "#{provider}:#{user_id}:*"
        redis_instance.del keys if keys.present?
      end
    
      def refresh(provider, user_id)
        keys = redis_instance.keys "#{provider}:#{user_id}:*"
        keys.each do |key|
          redis_instance.set(key, 'REFRESH')
        end
      end
    
      def get(refresh_token)
        value = redis_instance.get "#{refresh_token[:provider]}:#{refresh_token[:sub]}:#{refresh_token[:jti]}"
        raise Service::Errors::InvalidToken if value.blank?
    
        value
      end
    
      private
    
      attr_reader :redis_instance
    end
  end  
end
