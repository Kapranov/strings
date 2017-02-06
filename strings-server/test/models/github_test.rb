require "test_helper"

describe Github do
  let(:github) { Github.new }

  it "must be valid" do
    value(github).must_be :valid?
  end
end
