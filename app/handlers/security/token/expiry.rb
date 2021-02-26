# frozen_string_literal: true
module Security
  module Token
    class Expiry
      def expire_access
        (token_issued_at + access_time).to_i
      end
  
      def expire_refresh
        (token_issued_at + refresh_time).to_i
      end
  
      def token_issued_at
        Time.zone.now
      end
  
      private
  
      def access_time
        20.minutes
      end
  
      def refresh_time
        1.hour
      end
    end
  end
end
