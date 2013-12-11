require "spec_helper"

describe Oauth::AuthorizationsController do
  routes { Oauth::Engine.routes }

  describe "GET #new" do
    context "when user is not authenticated" do
      it "redirects to `SessionsController#new`" do
        get :new

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated" do
      login_user

      it "renders the access granting form" do
        get :new

        expect(response).to render_template :new
      end
    end
  end

  describe "POST #create" do
    let(:client) { Fabricate(:client) }

    context "when user is not authenticated" do
      it "redirects with error `access_denied` in the query component of `redirect_uri`" do
        post :create, application_id: client.application_id, redirect_uri: client.redirect_uri, response_type: "code"

        expect(response).to redirect_to([client.redirect_uri, {error: "access_denied", error_description: "The authorization server or resource owner denied the request."}.to_param].join('?'))
      end
    end

    context "when user is authenticated" do
      login_user

      it "redirects with `code` in query component of `redirect_uri`" do
        post :create, application_id: client.application_id, redirect_uri: client.redirect_uri, response_type: "code"

        expect(response).to redirect_to([client.redirect_uri, Oauth::Authorization.first().to_query].join('?'))
      end
    end
  end

  describe "POST #token" do
    let(:client)  { Fabricate(:client) }
    let(:auth)    { Fabricate(:authorization, client: client) }

    context "when client is not authenticated" do
      before do
        request.env['HTTP_REFERER'] = client.redirect_uri
      end

      it "redirects with error `unauthorized_client` in the query component of `redirect_uri`" do
        post :token, code: auth.code, application_id: client.application_id, redirect_uri: client.redirect_uri

        expect(response).to redirect_to([client.redirect_uri, {error_description: "The client is not authorized to make this request.", error: "unauthorized_client"}.to_param].join('?'))
      end
    end

    context "when client is authenticated" do
      before do
        request.env['HTTP_AUTHORIZATION'] = "#{client.application_id}:#{client.application_secret}"
      end

      it "redirects with `access_token` in the query component of `redirect_uri`" do
        post :token, code: auth.code, application_id: client.application_id, redirect_uri: client.redirect_uri

        expect(response).to redirect_to([client.redirect_uri, Oauth::Token.first().to_query].join('?') + '&token_type=bearer') # Why is this whining about missing arguments??
      end
    end
  end
end