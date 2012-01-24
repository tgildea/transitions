require "helper"

class TestEventBeingFired < Test::Unit::TestCase
  def setup
    @obj = stub(:current_state => :open)
  end

  test "should raise an Transitions::InvalidTransition error if the transitions are empty" do
    event = Transitions::Event.new(nil, :event)

    assert_raise Transitions::InvalidTransition do
      event.fire(@obj)
    end
  end

  test "should return the state of the first matching transition it finds" do
    event = Transitions::Event.new(nil, :event) do
      transitions :to => :closed, :from => [:open, :received]
    end

    assert_equal :closed, event.fire(@obj)
  end
end
