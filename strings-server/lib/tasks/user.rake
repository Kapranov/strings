namespace :user do
  desc "Add users Faker"
  task setup: :environment do
    generate_token = SecureRandom.base64(25).tr('+/=', 'Qrt')
    roles = %w[Manager Contributor Reviewer]
    puts "Create Users Account Faker"
    100.times do
      User.create!(
        first_name:   FFaker::Name.first_name,
        last_name:    FFaker::Name.last_name,
        middle_name:  FFaker::Name.other_prefix,
        apikey:       SecureRandom.base64(25).tr('+/=', 'Qrt'),
        password:     Rails.application.secrets.admin_password.to_s,
        email:        FFaker::Internet.email,
        description:  FFaker::Lorem.phrase,
        role:         roles.sample
      )
    end
    puts "Created Successful!"
  end
end
