describe ApplicationController do
  it "responds to `require_access_token`" do
    expect(controller).to respond_to(:require_access_token)
  end
end