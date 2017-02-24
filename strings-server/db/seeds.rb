# User.where(:name => /bob/).order_by(:name => :desc).to_a
# User.find "4M39V517kzBSpG"
# User.where(:first_name => /Oleg/).order_by(:first_name => :desc).to_a
# User.where(:isActive => false).sample(2)
# order_by()/reverse_order/without_ordering
# with_index/without_index/used_index/indexed?
# with_cache/without_cache/reload
# preload() - eager loading
# after_find()
# sample(n)
# merge() merge!()

# bash> rake nobrainer:sync_indexes
# bash> rake nobrainer:sync_schema
# bash> rake db:update_indexes
# console> NoBrainer.update_indexes
# console> Model.perform_update_indexes

# r.table('users').filter(lambda user: r.expr([1,2,3]).contains(user['id']) & (user['active'] == 1))
# r.table('users').filter(lambda user: r.all(r.expr([1,2,3]).contains(user['id']), user['active'] == 1))

# def index @users = User.where(:ranking.ne => 0).order_by(:ranking => :asc).limit(300).all; end
# token='BW4wU7g52VMyGEGtQn83VOIEy0IFG8dpKAtt'
# User.where(token: token.to_s).limit(1).to_a.first

# bash> rake nobrainer:sync_indexes
# User.create(first_name: 'Oleg', last_name: 'Kapranov', middle_name: 'G.', password: '12345678', email: 'lugatex@yahoo.com', description: 'Hello Wolrd!')

# users = []
# 5.times {|n| users << User.create(username: "user_#{n}") }

# AwesomeStuff.all.each { |aww| aww.update user: users.sample }

# User.first.awesome_stuffs

# json = ActiveSupport::JSON.decode(File.read('db/seeds/posts.json'))
# json.each do |post|
#   record = Post.new post
#   record.author = author;
#   record.save!
# end

#
# images = [
#   'https://unsplash.com/?photo=b1NFkUR-3Fg/download?force=true',
#   'https://unsplash.com/?photo=3IEZsaXmzzs/download?force=true',
#   'https://unsplash.com/?photo=9O1oQ9SzQZQ/download?force=true',
#   'https://unsplash.com/?photo=zNN6ubHmruI/download?force=true',
#   'https://unsplash.com/?photo=vL4ARRCFyg4/download?force=true',
#   'https://unsplash.com/?photo=eJx43ng-fTU/download?force=true',
#   'https://unsplash.com/?photo=oiLGd4Dd7eY/download?force=true',
#   'https://unsplash.com/?photo=XN_CrZWxGDM/download?force=true',
#   'https://unsplash.com/?photo=cmKPOUgdmWc/download?force=true',
#   'https://unsplash.com/?photo=7bwQXzbF6KE/download?force=true'
# ]
#
# 10.times.each do |count|
#   trip = user.trips.create!(name: "Pune trip #{count}", description: "Was mostly in summer #{count}")
#   trip.tag_list.add(*tags.sample(rand(10)))
#   trip.save!
#
#   place = trip.places.create!(name: "Agakhan Palace #{count}", description: "A very nice place #{count}", review: 'A good review')
#   place.pictures.create!(url: images[count], description: 'just a pic')
# end

if Rails.env.development?
  puts "--------Creating Token--------------------------------"
  # token = Token.create!
  token = CreateToken.new.call
  puts 'CREATED APIs   TokenId: ' << token.id
  puts 'CREATED APIs  TokenKey: ' << token.apikey
  puts 'CREATED APIs  Username: ' << token.username
  puts 'CREATED APIs  Password: ' << token.password
  puts "--------Creating Users--------------------------------"
  user = CreateAdmin.new.call
  puts 'CREATED ADMIN       Id: ' << user.id
  puts 'CREATED ADMIN     User: ' << user.email
  puts 'CREATED ADMIN     Role: ' << user.role.to_s
  puts "--------Creating Access-------------------------------"
  access = CreateAccess.new.call
  puts 'CREATED Access      Id: ' << access.id
  puts 'CREATED Access  UserId: ' << access.user_id
  puts 'CREATED Access     Key: ' << access.key
  puts "--------Creating  JWT---------------------------------"
  jwt_encode = AccessToken.generate(user_id: access.user_id)
  jwt_decode = AccessToken.decode(jwt_encode).to_s
  puts 'CREATED Encode  UserId: ' << access.user_id
  puts 'CREATED JWT for Encode: ' << jwt_encode
  puts 'CREATED JWT for Decode: ' << jwt_decode
  puts "--------Creating Movies-------------------------------"
  # movie = CreateMovie.new.call
  puts "--------Creating Github-------------------------------"
  # github = CreateGithub.new.call
end

if Rails.env.test?
  puts "--------Seeding Data Start----------------------------"
  user = CreateAdmin.new.call
  puts 'CREATED ADMIN USER: ' << user.email
  puts "--------Seeding Data End------------------------------"
end

if Rails.env.production?

end
