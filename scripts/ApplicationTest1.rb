#!/usr/bin/env ruby

unless File.exist?('Gemfile')
  File.write('Gemfile', <<-GEMFILE)
  source 'https://rubygems.org'

  ruby '2.3.3'

  gem 'rails', '5.0.1'
  gem 'arel'
  gem 'sqlite3'
  gem 'active_model_serializers', '0.10.4'
  gem 'pry'
  GEMFILE

  system 'bundle'

  require 'bundler'
  Bundler.setup(:default)

  require 'active_record'
  require 'active_model_serializers'
  require 'minitest/autorun'
  require 'logger'

  ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
  ActiveRecord::Base.logger = Logger.new(STDOUT)

  ActiveRecord::Schema.define do
    create_table :posts, force: true  do |t|
      t.string :title
      t.text :body
    end
  end

  class Post < ActiveRecord::Base
    include ActiveModel::Serialization
    # include ActiveModel::Serializers::JSON

    validates :title, :body, presence: true

    def achievements_summary
      [{ achievement_id: "examplecourse1", count: 4, credential_name: "Example Course" }]
    end

    def templates_summary
      [{ template_name: "sample template", template_id: 3, count: 0 }]
    end
  end

  class PostSerializer < ActiveModel::Serializer

    attributes :achievements, :templates

    def achievements
      object.achievements_summary
    end

    def templates
      object.templates_summary
    end

    class BugTest < Minitest::Test
      def test_json
        post = Post.create!(title: 'Test filter', body: 'Test if the filter method is working fine')
        assert_equal PostSerializer.new(post).to_json, {post: {achievements: post.achievements_summary, templates: post.templates_summary}}.to_json
      end
    end

  end

  Post.find_or_create_by(title: "The New York Times", body: "Trump Backers Like His First Draft of a New America")

  puts Post.first.as_json
end

