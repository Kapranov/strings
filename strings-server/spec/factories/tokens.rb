FactoryGirl.define do
  factory :token do
    apikey {"#{SecureRandom.base64(25).tr('+/=', 'Qrt')}"}
    username {"#{FFaker::Name.name}"}
    password_digest {"#{FFaker::Internet.password}"}
    state "active"
  end
end
