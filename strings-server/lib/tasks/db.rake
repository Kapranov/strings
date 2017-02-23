namespace :db do
  unless Rails.env == 'production'
    desc 'Drop and setup the development database'
    task reload:
      %w(environment nobrainer:drop nobrainer:sync_indexes nobrainer:seed) do
      puts "Reloading of #{Rails.env} complete."
    end
  end
end
