module Oauth
  module Strategy
    class ClientCredentials
      attr_reader :request

      def initialize(request)
        @request = request
      end

      def get_access_token
        token = Oauth::Token.create(application_id: request.application_id)

        request.respond_with({token_type: "bearer"}.merge(token.to_hash))
      end
    end
  end
end