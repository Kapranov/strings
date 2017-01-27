require 'test_helper'

describe User do
  let(:user) { User.new }

  it 'Should not be valid' do
    value(user).wont_be :valid?
  end
end
