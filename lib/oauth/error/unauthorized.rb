module Oauth
  module Error
    class Unauthorized < OauthError
      def self.to_hash
        new("unauthorized", "Unauthorized").to_hash
      end

      def self.to_json
        new("unauthorized", "Unauthorized").to_json
      end
    end
  end
end