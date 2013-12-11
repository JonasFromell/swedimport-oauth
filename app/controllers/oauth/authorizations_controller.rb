module Oauth
  class AuthorizationsController < ApplicationController
    before_filter :authenticate_user!, only: [:new]

    # Authorize endpoint for `response_type=code`
    #
    # @param params[:application_id]
    # @param params[:redirect_uri]
    def new
      
    end

    # @param params[:application_id]
    # @param params[:redirect_uri]
    def create
      @request = Request.new(params)

      if user_signed_in?
        response = @request.authorization_code.get_code(current_user)

        redirect_to Http::Uri.build(@request.redirect_uri, response.options)
      else
        redirect_to Http::Uri.build(@request.redirect_uri, Oauth::Error::AccessDenied.to_hash)
      end
    end

    # Token endpoint for `grant_type=authorization_code`
    #
    # @param params[:application_id]
    # @param params[:redirect_uri]
    # @param params[:code]
    def token
      @request = Request.new(params)

      if authenticate_client!
        response = @request.authorization_code.get_access_token

        redirect_to Http::Uri.build(@request.redirect_uri, response.options)
      else
        redirect_to Http::Uri.build(@request.redirect_uri, Oauth::Error::UnauthorizedClient.to_hash)
      end
    end

    protected

    def authenticate_client!
      authenticate_with_http_basic { |u, p| Client.authenticate(u, p) }
    end
  end
end