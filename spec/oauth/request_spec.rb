require "spec_helper"

describe Oauth::Request, "instance method" do
  context "#respond_with" do
    it "returns a `Oauth::Response` object" do
      res = Oauth::Request.new().respond_with({})

      expect(res).to be_a(Oauth::Response)
    end
  end
end