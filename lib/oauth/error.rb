module Oauth
  module Error
    class Base < StandardError
      attr_reader :code, :description

      def initialize(code, description)
        @code = code
        @description = description

        super("#{@code}: #{@description}")
      end

      def to_hash
        {error: code, error_description: description}
      end
    end

    class AccessDenied < Base
      def self.to_hash
        new("access_denied", "The authorization server or resource owner denied the request.").to_hash
      end
    end

    class UnauthorizedClient < Base
      def self.to_hash
        new("unauthorized_client", "The client is not authorized to make this request.").to_hash
      end
    end
  end
end