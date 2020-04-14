FactoryBot.define do
  factory :user do
    id { 1 }
    first_name { 'John' }
    last_name { 'Doe' }
    email     { 'test@user.com' }
    password  { 'mypass1' }
  end
end
