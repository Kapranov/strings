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


if Rails.env.development?
  puts "--------Creating Token--------------------------------"
  # token = Token.create!
  token = CreateTokenService.new.call
  puts 'CREATED APIs Token key: ' << token.apikey
  puts 'CREATED APIs  Username: ' << token.username
  puts 'CREATED APIs  Password: ' << token.password
  puts "--------Creating Users--------------------------------"
  user = CreateAdminService.new.call
  puts 'CREATED ADMIN USER: ' << user.email
  puts "--------Creating Movies-------------------------------"
  # movie = CreateMovieService.new.call
  puts "--------Creating Github-------------------------------"
  # github = CreateGithubService.new.call
end

if Rails.env.test?
  puts "--------Seeding Data Start----------------------------"
  user = CreateAdminService.new.call
  puts 'CREATED ADMIN USER: ' << user.email
  puts "--------Seeding Data End------------------------------"
end

if Rails.env.production?

end
