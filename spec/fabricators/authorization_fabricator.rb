Fabricator(:authorization, from: "Oauth::Authorization") do
  transient :client

  application_id { |attrs| attrs[:client] ? attrs[:client].application_id : 1 }
  redirect_uri { |attrs| attrs[:client] ? attrs[:client].redirect_uri : "http://example.com" }

  code "somerandomstring"

  user
end