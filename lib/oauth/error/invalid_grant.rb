module Oauth
  module Error
    class InvalidGrant < Base
      def name
        "invalid_grant"
      end

      def message
        "The provided authorization grant (e.g. authorization code, resource owner credentials) or refresh token is invalid, expired, revoked, does not match the redirection URI used in the authorization request, or was issued to another client."
      end
    end
  end
end