module Oauth
  module Error
    class OauthError < StandardError
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
  end
end