require "spec_helper"

describe Oauth::ClientsController do
  routes { Oauth::Engine.routes }

  let(:client) { Fabricate(:client) }
  let(:params) do
    { application_id: client.application_id, redirect_uri: client.redirect_uri }
  end

  describe "POST #token" do
    context "when client is not authenticated" do
      it "redirects with error `UnauthorizedClient`" do
        post :token, params

        expect(response).to redirect_to([client.redirect_uri, Oauth::Error::UnauthorizedClient.to_hash.to_param].join('?'))
      end
    end

    context "when client is authenticated" do
      before(:each) do
        request.env['HTTP_AUTHORIZATION'] = "#{client.application_id}:#{client.application_secret}"
      end

      it "redirects with the access token in query" do
        post :token, params

        expect(response).to redirect_to([client.redirect_uri, Oauth::Token.last().to_hash.to_param + '&token_type=bearer'].join('?'))
      end
    end
  end
end