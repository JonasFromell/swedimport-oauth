module Oauth
  module Request
    class AuthorizationCode < Base
      # Class methods
      #
      #
      class << self
        def for(user, params)
          # New request
          request = new(params.merge(user: user))
        end
      end

      # Instance methods
      #
      #

      # Returns an authorization code for this request
      #
      # Throws access denied error if `user` is missing from the request or any other exception is caught
      #
      # @return [Response]
      def get_authorization_code
        raise Oauth::Error::AccessDenied unless auth = user.authorizations.create(application_id: application_id, redirect_uri: redirect_uri)

        Oauth::Response::AuthorizationCode.new(auth.to_param)
      end

      def valid?
        [response_type, application_id, redirect_uri].all?
      end

      def client?
        Client.find_by(application_id: application_id, redirect_uri: redirect_uri)
      end
    end
  end
end