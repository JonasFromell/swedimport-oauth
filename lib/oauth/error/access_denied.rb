module Oauth
  module Error
    class AccessDenied < OauthError
      def self.to_hash
        new("access_denied", "The authorization server or resource owner denied the request.").to_hash
      end
    end
  end
end