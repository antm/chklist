require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test 'should create tasks' do
    assert_difference 'Task.count' do
      task = Task.create(title: 'title copy')
    end
  end

  test 'should require title' do
    assert_no_difference 'Task.count' do
      task = Task.create
    end
  end

end
