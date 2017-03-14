if Rails.env.development?

  User.destroy_all
  Room.destroy_all
  Card.destroy_all
  Phone.destroy_all

  puts "--------Creating Token--------------------------------"
  token = CreateTokenService.new.call
  puts 'CREATED        TokenId: ' << token.id
  puts 'CREATED      AuthToken: ' << token.auth_token
  puts 'CREATED       UserName: ' << token.username
  puts 'CREATED       Password: ' << token.password
  puts 'CREATED          State: ' << token.state
  puts "--------Creating Admin--------------------------------"
  admin = CreateAdminService.new.call
  puts 'CREATED             Id: ' << admin.id
  puts 'CREATED          eMail: ' << admin.email
  puts 'CREATED     MiddleName: ' << admin.middle_name
  puts 'CREATED       UserName: ' << admin.last_name
  puts 'CREATED      FirstName: ' << admin.first_name
  puts 'CREATED          Admin: ' << admin.admin.to_s
  puts 'CREATED           Role: ' << admin.role.to_s
  puts 'CREATED          State: ' << admin.state
  puts 'CREATED       Password: ' << admin.password
  puts 'CREATED       ApiToken: ' << admin.auth_token
  puts 'CREATED    Description: ' << admin.description
  puts "--------Creating Phone--------------------------------"
  phone = CreatePhoneService.new.call
  puts 'CREATED         UserId: ' << phone.user_id
  puts 'CREATED           Name: ' << phone.name
  puts 'CREATED    PhoneNumber: ' << phone.phone_number
  puts "--------Creating Users--------------------------------"
  user = CreateUsersService.new.call
  puts "------------------------------------------------------"
end

if Rails.env.test?
end

if Rails.env.production?
end
