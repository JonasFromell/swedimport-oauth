require "spec_helper"

describe Oauth::Response, "instance method" do
  let(:req) { Oauth::Request.new({redirect_uri: "http://example.com"}) }

  context "#to_param" do
    it "constructs a valid URI from the request and options" do
      res = Oauth::Response.new(req, {key: "value"})

      expect(res.to_param).to eq("http://example.com?key=value")
    end
  end
end