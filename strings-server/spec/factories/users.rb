FactoryGirl.define do
  factory :user do
    first_name {"#{FFaker::Name.first_name}"}
    last_name {"#{FFaker::Name.last_name}"}
    middle_name {"#{FFaker::Name.other_prefix}"}
    password_digest {"#{FFaker::Internet.password}"}
    email {"#{FFaker::Internet.email}"}
    apikey {"#{SecureRandom.base64(25).tr('+/=', 'Qrt')}"}
    description {"#{FFaker::Lorem.phrase}"}
  end
end
