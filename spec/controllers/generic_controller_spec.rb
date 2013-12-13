describe ApplicationController do
  context "#require_access_token" do
    it "responds to `require_access_token`" do
      expect(controller).to respond_to(:require_access_token)
    end
  end
end

describe OauthController do
    context "#require_access_token" do
      context "format HTML" do
        let(:token) { Fabricate(:token).token }

        it "responds with 200 OK if access token is valid" do
          get :new, access_token: token

          expect(response.status).to eq(200)
        end

        it "responds with 401 Unauthorized if no access token is invalid" do
          get :new

          expect(response.status).to eq(401)
        end
      end

      context "format JSON" do
        before do
          request.accept = "application/json"
        end

        it "responds with body of unauthorized error if no access token is supplied" do
          get :new

          expect(response.body).to eq(Oauth::Error::Unauthorized.to_json)
          expect(response.status).to eq(401)
        end
      end
    end
end