# frozen_string_literal: true

require 'test_helper'

class RailsControllerTest < ActionDispatch::IntegrationTest
  test 'should get d' do
    get rails_d_url
    assert_response :success
  end

  test 'should get controller' do
    get rails_controller_url
    assert_response :success
  end

  test 'should get sessions' do
    get rails_sessions_url
    assert_response :success
  end
end
