require "spec_helper"

describe Oauth::Request::AuthorizationCode do
  let(:req) { Oauth::Request::AuthorizationCode }

  it "should raise `InvalidRequest` error if `valid?` returns false" do
    expect { req.new({response_type: false, client_id: true, redirect_uri: true}) }.to raise_error(Oauth::Error::InvalidRequest)
  end

  it "should raise `UnauthorizedClient` error if `client?` returns false" do
    expect { req.new({response_type: true, client_id: true, redirect_uri: true}) }.to raise_error(Oauth::Error::UnauthorizedClient)
  end 
end

describe Oauth::Request::AuthorizationCode, "instance method" do
  let(:req) { Oauth::Request::AuthorizationCode }
  let(:params) { {response_type: "code", client_id: client.application_id, redirect_uri: client.redirect_uri} }

  context "#get_authorization_code" do
    let(:client) { Fabricate(:client) }

    it "should raise `AccessDenied` error if it fails" do
      expect { req.new({response_type: "code", client_id: client.application_id, redirect_uri: client.redirect_uri}).get_authorization_code }.to raise_error(Oauth::Error::AccessDenied)
    end

    let(:user) { Fabricate(:user) }

    it "should create a new `Authorization`" do
      expect { req.new(params.merge(user: user)).get_authorization_code }.to change(Oauth::Authorization, :count).by(1)
    end
  end
end

describe Oauth::Request::AuthorizationCode, "class method" do
  let(:client) { Fabricate(:client) }

  context "#for" do

  end
end