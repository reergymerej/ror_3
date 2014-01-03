FactoryGirl.define do
  factory :user do
    name 'Sammy'
    email 'sweet@pea.com'
    password 'foobar'
    password_confirmation 'foobar'
  end
end