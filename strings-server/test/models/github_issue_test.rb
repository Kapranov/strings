require "test_helper"

describe GithubIssue do
  let(:github_issue) { GithubIssue.new }

  it "must be valid" do
    value(github_issue).must_be :valid?
  end
end
