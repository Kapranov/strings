require 'cucumber/rails'

ActionController::Base.allow_rescue = false

Cucumber::Rails::Database.javascript_strategy = :truncation
Cucumber::Rails::Database.autorun_database_cleaner = false
