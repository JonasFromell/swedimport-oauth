module Oauth
  class ClientsController < ApplicationController
    after_filter :set_headers, only: [:token]
    # Token endpoint for `grant_type=client_credentials`
    #
    # @param params grant_type
    def token
      @request = Request.new(params)

      if authenticate_client!
        response = @request.client_credentials.get_access_token

        respond_to do |format|
          format.html { redirect_to Http::Uri.build(@request.redirect_uri, response.to_hash) }
          format.json { render json: response.to_json, location: @request.redirect_uri }
        end
      else
        respond_to do |format|
          format.html { redirect_to Http::Uri.build(@request.redirect_uri, Oauth::Error::UnauthorizedClient.to_hash) }
          format.json { render json: Oauth::Error::UnauthorizedClient.to_json, location: @request.redirect_uri }
        end
      end
    end
  end
end