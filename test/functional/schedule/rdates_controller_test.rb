require 'test_helper'

class Schedule::RdatesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should not create new rdate if not bodo" do
    event = FactoryGirl.create(:simple)

    put :create, :event_id => event.id, :rdate => {
      "date(1i)" => "1980",
      "date(2i)" => "5",
      "date(3i)" => "1",
      "date(4i)" => "12",
      "date(5i)" => "30"
    }
    assert_not_nil flash.alert
    assert_redirected_to root_path

    sign_in FactoryGirl.create(:user)
    put :create, :event_id => event.id, :rdate => {
      "date(1i)" => "1980",
      "date(2i)" => "5",
      "date(3i)" => "1",
      "date(4i)" => "12",
      "date(5i)" => "30"
    }
    assert_not_nil flash.alert
    assert_redirected_to root_path
  end

  test "should not delete new rdate if not bodo" do
    event = FactoryGirl.create(:simple)

    delete :destroy, :event_id => event.id, :id => 0
    assert_not_nil flash.alert
    assert_redirected_to root_path

    sign_in FactoryGirl.create(:user)
    delete :destroy, :event_id => event.id, :id => 0
    assert_not_nil flash.alert
    assert_redirected_to root_path
  end

  test "should create and delete new rdate if bodo" do
    event = FactoryGirl.create(:simple)

    sign_in FactoryGirl.create(:bodo)
    put :create, :event_id => event.id, :rdate => {
      "date(1i)" => "1980",
      "date(2i)" => "5",
      "date(3i)" => "1",
      "date(4i)" => "12",
      "date(5i)" => "30"
    }
    assert_not_nil flash.notice
    assert_redirected_to event_path(event)
    event = Event.find(event.id)
    assert_equal 1, event.schedule.rdates.count
    assert_equal Time.new(1980,5,1,12,30), event.schedule.rdates.first

    delete :destroy, :event_id => event.id, :id => 0
    assert_not_nil flash.notice
    assert_redirected_to event_path(event)
    event = Event.find(event.id)
    assert_equal 0, event.schedule.rdates.count
  end

end
