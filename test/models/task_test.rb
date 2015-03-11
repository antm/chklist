require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  def setup # called before every test
    @valid_task = Task.new(title: 'my title', starttime: Time.new)
  end

  # TODO: delete this as it simply tests if Rails works?
  test 'should create tasks' do
    assert_difference 'Task.count' do
      @valid_task.save
    end
  end

  # FIXME: passes despite only 'testing' title. Isolate title. 
  test 'should require title' do
    assert_no_difference 'Task.count' do
      @valid_task.reverse_merge(title: nil)
    end
  end

  test 'should require starttime' do
    assert_no_difference 'Task.count' do
      @valid_task.reverse_merge(starttime:nil)
    end
  end

  test 'assigns a position before save' do 
    flunk 'todo'
  end
end

