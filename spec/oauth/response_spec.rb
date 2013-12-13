require "spec_helper"

describe Oauth::Response, "instance method" do
  context "#to_hash" do
    it "returns the response as a hash" do
      expect(described_class.new(nil, {key: "value"}).to_hash).to eq({key: "value"})
    end
  end

  context "#to_json" do
    it "returns the response as json" do
      expect(described_class.new(nil, {key: "value"}).to_json).to eq({key: "value"}.to_json)
    end
  end
end