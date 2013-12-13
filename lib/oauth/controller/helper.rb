module Oauth
  module Controller
    module Helper
      extend ActiveSupport::Concern
      
      included do
        helper_method :require_access_token
      end

      def require_access_token
        if token && token.valid?
          true
        else
          respond_to do |format|
            format.html { head :unauthorized }
            format.json { render json: Oauth::Error::Unauthorized.to_json, status: 401 }
          end
        end
      end

      private

      def token
        Oauth::Token.find_by(token: params[:access_token])
      end
    end
  end
end