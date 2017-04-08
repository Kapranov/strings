if Rails.env.development?

  User.destroy_all
  Room.destroy_all
  Card.destroy_all
  Phone.destroy_all

  puts "--------Creating Token--------------------------------------"
  token = CreateTokenService.new.call
  puts 'CREATED        TokenId: ' << token.id
  puts 'CREATED      AuthToken: ' << token.auth_token
  puts 'CREATED       UserName: ' << token.username
  puts 'CREATED       Password: ' << token.password
  puts 'CREATED          State: ' << token.state
  puts 'CREATED   Total Tokens: ' << "#{Token.count}"
  puts "--------Creating Admin--------------------------------------"
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
  puts "--------Creating Admin Phone--------------------------------"
  cell = CreateAdminService.new.cell
  work = CreateAdminService.new.work
  home = CreateAdminService.new.home
  Phone.each {
    |phone| puts "id:#{phone.id}" + ' ' + "User:#{phone.user_id}" +
    ' ' + "name:#{phone.name}:#{phone.phone_number}"
  }
  puts "--------Creating Users--------------------------------------"
  user = CreateUsersService.new.call
  puts 'CREATED   Total Users: ' << "#{User.count}"
  puts "--------Creating Rooms--------------------------------------"
  room = CreateRoomsService.new.call
  puts 'CREATED   Total Rooms: ' << "#{Room.count}"
  puts "--------Creating Cards--------------------------------------"
  card = CreateCardsService.new.call
  puts 'CREATED   Total Cards: ' << "#{Card.count}"
  puts "------------------------------------------------------------"
end

if Rails.env.test?
end

if Rails.env.production?
end
