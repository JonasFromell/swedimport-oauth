require "spec_helper"

describe Oauth::Strategy::AuthorizationCode, "instance method" do
  context "#get_code" do
    let(:user) { Fabricate(:user) }
    let(:req)  { Oauth::Request.new(application_id: "somerandomstring", redirect_uri: "http://example.com") }
    let(:res)  { described_class.new(req).get_code(user) }

    it "returns a `Oauth::Response` object" do
      expect(res).to be_a(Oauth::Response)
    end
  end

  context "#get_access_token" do
    let(:code) { Fabricate(:authorization).code }
    let(:req)  { Oauth::Request.new(application_id: "somerandomstring", redirect_uri: "http://example.com", code: "somerandomstring") }
    let(:res)  { described_class.new(req).get_access_token }

    it "returns a `Oauth::Response` object" do
      expect(res).to be_a(Oauth::Response)
    end
  end
end