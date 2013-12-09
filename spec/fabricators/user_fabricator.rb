Fabricator(:user, from: "Oauth::User") do
  first_name "John"
  last_name "Doe"
  email "john.doe@example.com"
  password "password"
end