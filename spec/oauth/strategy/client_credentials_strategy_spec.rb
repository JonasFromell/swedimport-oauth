require "spec_helper"

describe Oauth::Strategy::ClientCredentials, "instance method" do
  context "#get_access_token" do
    let(:req) { Oauth::Request.new(application_id: "somerandomstring", redirect_uri: "http://example.com") }
    let(:res) { described_class.new(req).get_access_token }

    it "returns a `Oauth::Response` object" do
      expect(res).to be_a(Oauth::Response)
    end
  end
end