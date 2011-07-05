# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :word do |word|
  word.word "brevity"
end

Factory.define :definition do |definition|
  definition.content "shortness"
  definition.association :word
end

Factory.define :example do |example|
  example.content "brevity is required for text messages and tweets"
  example.association :word
end
