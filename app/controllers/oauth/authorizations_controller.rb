module Oauth
  class AuthorizationsController < ApplicationController
    before_filter :authenticate_user!, except: [:token] # Token only needs to authenticate the client (?)

    # Ask `current_user` for permission to access their account
    #
    # @param [String] application_id
    # @param [String] redirect_uri
    def new
      
    end

    # Grant client access to `current_user` account
    #
    # @param [String] application_id
    # @param [String] redirect_uri
    def create
      begin
        # Get the authorization code
        res = Oauth::Request::AuthorizationCode.for(current_user, params).get_authorization_code

        redirect_to res.to_uri
      rescue Oauth::Error => e
        redirect_to([params.redirect_uri, e.to_param].join('?'))
      end
    end

    # Returns the access token for this authorization
    #
    # @param [String] grant_type
    # @param [String] code
    def token
      begin
        # Client has to be authenticated for this request
        client = authenticate_client!

        # Get the access token
        res = Oauth::Request::AccessToken.for(client, params).get_access_token

        redirect_to res.to_uri
      rescue Oauth::Error::UnauthorizedClient => e
        redirect_to [request.referer, e.to_param].join('?')
      rescue Oauth::Error::InvalidGrant => e
        redirect_to [client.redirect_uri, e.to_param].join('?')
      end
    end

    protected

    def authenticate_client!
      if client = authenticate_with_http_basic { |u, p| Client.authenticate(u, p) }
        client
      else
        raise Oauth::Error::UnauthorizedClient
      end
    end
  end
end