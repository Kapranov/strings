#!/usr/bin/env ruby

github = Github.new basic_auth: 'login:password'
github.repos.hooks.create 'user-name', 'repo-name',
name:  "web", active: true, events: ['push','pull-request'],
config: {
  url: "http://localhost:3000/payload", content_type: "json"
}
