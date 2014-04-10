require "spec_helper"

describe "Authorization code flow" do
  let(:client) { Fabricate(:client, redirect_uri: callback_path) }
  let(:user)   { Fabricate(:user) }

  context "#authorize endpoint" do
    it "displays a sign in form if not already signed in" do
      visit "/oauth/authorize?response_type=code&application_id=#{client.application_id}&redirect_uri=#{client.redirect_uri}"

      # We'll be redirected to the sign in form
      expect(page).to have_content("Sign in")
    end

    it "displays a access granting form if/after user is signed in" do
      visit "/oauth/authorize?response_type=code&application_id=#{client.application_id}&redirect_uri=#{client.redirect_uri}"

      # We'll be redirected to the sign in form
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password

      click_button "Sign in"

      # Here we'll choose to grant access or not
      expect(page).to have_content "Grant access?"
    end
  end
end