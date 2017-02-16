namespace :notify do
  desc 'Send an email for users who have been inactive for a month'
  task notify_inactive_users: :environment do
    users = User.where('last_sign_in_at <= ?', Time.now - 30.days).each do |user|
      puts "Notifying #{user.email}"
      Notifications.inactive_user(user).deliver
    end

    puts "Notified #{users.count} user(s)"
  end
end
