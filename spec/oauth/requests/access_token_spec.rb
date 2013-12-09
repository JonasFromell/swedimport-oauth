require "spec_helper"

describe Oauth::Request::AccessToken, "instance method" do
  let(:req) { Oauth::Request::AccessToken }

  context "#get_access_token" do
    it "should raise `InvalidGrant` error if authorization is not found" do
      expect { req.new(code: "somerandomstring", grant_type: "authorization_code").get_access_token }.to raise_error(Oauth::Error::InvalidGrant)
    end

    let(:auth) { Fabricate(:authorization) }
    let(:client) { Fabricate(:client) }

    it "should raise `InvalidGrant` error if authorization code was not issued for the client that made the request" do
      expect { req.new(code: "somerandomstring", grant_type: "authorization_code", client: client).get_access_token }.to raise_error(Oauth::Error::InvalidGrant)
    end

    let(:client) { Fabricate(:client) }
    let(:auth) { Fabricate(:authorization, client: client) }

    it "should create a new `AccessToken`" do
      expect { req.new(code: auth.code, grant_type: "authorization_code", client: client).get_access_token }.to change(Oauth::Token, :count).by(1)
    end
  end
end