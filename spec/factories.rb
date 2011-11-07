# By using the symbol ':user', we get Factory Girl to simulate
# the User model
Factory.define :user do |user|
  user.first_name            "Jonathan"
  user.last_name             "He"
  user.email                 "jon@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
