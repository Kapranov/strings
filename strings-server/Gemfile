rails_version = ENV["RAILS_VERSION"] || "default"

rails = case rails_version
        when "default"
          "~> 5.0"
        else
          "~> #{rails_version}"
        end

version = ENV["RAILS_VERSION"] || '5.0'
eval_gemfile File.expand_path("../gemfiles/#{version}.gemfile", __FILE__)
