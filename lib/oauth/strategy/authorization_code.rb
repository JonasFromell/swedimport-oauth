module Oauth
  module Strategy
    class AuthorizationCode
      attr_reader :request

      def initialize(request)
        @request = request
      end

      def get_code(resource_owner)
        auth = resource_owner.authorizations.create(application_id: request.application_id, redirect_uri: request.redirect_uri)

        request.respond_with({code: auth.code})
      end

      def get_access_token
        unless Oauth::Authorization.find_by(code: request.code, application_id: request.application_id, redirect_uri: request.redirect_uri)
          false
        end

        token = Oauth::Token.create(application_id: request.application_id)

        request.respond_with({token_type: "bearer"}.merge(token.to_hash))
      end
    end
  end
end