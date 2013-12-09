require "spec_helper"

describe Oauth::AuthorizationsController do
  routes { Oauth::Engine.routes }

  context "#new" do
    it "redirects to `users/sign_in` if user is not logged in" do
      sign_in nil

      get :new, response_type: "code"

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "#create" do

  end

  context "#token" do
    before do
      request.env['HTTP_REFERER'] = 'http://example.com'
    end

    it "should redirect back if client is not authenticated" do
      get :token, { grant_type: "authorization_code", code: "somerandomstring" }

      expect(response).to redirect_to('http://example.com?description=The+client+is+not+authorized+to+request+an+authorization+code+using+this+method.&error=unauthorized_client')
    end
  end
end