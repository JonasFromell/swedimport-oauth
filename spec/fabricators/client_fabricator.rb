Fabricator(:client, from: "Oauth::Client") do
  name "Some application"
  redirect_uri "http://www.example.com"
end