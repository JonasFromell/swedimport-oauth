module Oauth
  module Controller
    module Helper
      extend ActiveSupport::Concern
      
      included do
        helper_method :require_access_token
      end

      def require_access_token
        token.valid?
      end

      private

      def token
        Oauth::Token.find_by(access_token: params[:access_token])
      end
    end
  end
end