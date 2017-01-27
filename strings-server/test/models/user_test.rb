require 'test_helper'

describe User do
  let(:user) { User.new }

  it 'no debe ser válido' do
    value(user).wont_be :valid?
  end
end
