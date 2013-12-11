require "spec_helper"

describe Oauth::Http::Uri, "class method #parse" do
  let(:uri) { Oauth::Http::Uri.parse("http://example.com/index.html?code=somerandomstring") }

  context "given `http://example.com?code=somerandomstring" do
    it "should have a `scheme` attribute with a value of `http`" do
      expect(uri).to respond_to(:scheme)
      expect(uri.scheme).to eq("http")
    end

    it "should have a `host` attribute with a value of `example.com`" do
      expect(uri).to respond_to(:host)
      expect(uri.host).to eq("example.com")
    end

    it "should have a `path` attribute with a value of `index.html`" do
      expect(uri).to respond_to(:path)
      expect(uri.path).to eq("index.html")
    end 

    it "should have a `query` attribute with a value of `?code=somerandomstring`" do
      expect(uri).to respond_to(:query)
      expect(uri.query).to eq("code=somerandomstring")
    end
  end
end

describe Oauth::Http::Uri, "class method #build" do
  let(:uri) { Oauth::Http::Uri.build("http://example.com", { code: "somerandomstring", state: "someotherrandomstring" }) }

  context "given a string and a hash" do
    it "should convert the hash to a query and add it to the string" do
      expect(uri).to eq("http://example.com?code=somerandomstring&state=someotherrandomstring")
    end
  end
end

describe Oauth::Http::Uri, "instance method #params" do
  let(:uri) { Oauth::Http::Uri.parse("http://example.com/index.html?code=somerandomstring&state=someotherrandomstring") }

  context "given `http://example.com/index.html?code=somerandomstring&state=someotherrandomstring`" do
    it "should return a hash with keys `code` and `state`" do
      expect(uri.params).to eq({code: "somerandomstring", state: "someotherrandomstring"})
    end
  end
end