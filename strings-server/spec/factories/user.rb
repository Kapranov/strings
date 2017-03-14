FactoryGirl.define do
  factory :user do
    email "MyString"
    first_name "MyString"
    last_name "MyString"
    middle_name "MyString"
    password "MyString"
    role User.set_default_role
    state "MyString"
    admin false
  end
end
