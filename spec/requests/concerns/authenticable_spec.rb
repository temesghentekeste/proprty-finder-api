require 'rails_helper'

class MockController
  include Authenticable
  attr_accessor :request

  def initialize
    mock_request = Struct.new(:headers)
    self.request = mock_request.new({})
  end
end

RSpec.describe 'properties', type: :request do
  before(:all) do
    @user = FactoryBot.create(:user)
  end
  it 'should get user from Authorization token' do
    @authentication = MockController.new

    @authentication.request.headers['Authorization'] = JsonWebToken.encode(user_id: @user.id)
    expect(@authentication.current_user).to be_truthy
    expect(@authentication.current_user).to eq(@user)
  end

  it 'should not get user from empty Authorization token' do
    @authentication = MockController.new

    @authentication.request.headers['Authorization'] = nil
    expect(@authentication.current_user).to eq(nil)
  end
end
