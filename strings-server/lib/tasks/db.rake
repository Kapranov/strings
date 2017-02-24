namespace :db do
  unless Rails.env == 'production'
    desc 'Clean up the some tables to DB'
    task clean: :environment do
      User.destroy_all
      Token.destroy_all
      Access.destroy_all
      puts "Clean User. Token, Access database.\n"
    end

    desc "Drop, create indexes then Seed Databases"
    task admin:
      %w(environment nobrainer:sync_indexes nobrainer:seed) do
      puts "Data of #{Rails.env} by Complete."
    end

    desc "Generate the Users FFaker"
    task users: :environment do
      generate_token = SecureRandom.base64(25).tr('+/=', 'Qrt')
      roles = %w[Manager Contributor Reviewer]
      puts "Generate new users"
      10.times do
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
      puts "Created Users by Successful!"
    end
  end
end
