require 'test_helper'

class PointTest < ActiveSupport::TestCase
  test "latitude should be presented " do
    point = Point.new
    point.longitude = '74.612757'

    assert_not point.save
  end

  test "longitude should be presented " do
    point = Point.new
    point.latitude = '42.87793'

    assert_not point.save
  end

  test "coordinates should have two digest before point" do
    point = Point.new
    point.latitude = '42.87793'
    point.longitude = '743.612757'

    assert_not point.save
  end

  test "courdinates should consist from integer" do
    point = Point.new
    point.latitude = '42.87k793'
    point.longitude = '74.612757'

    assert_not point.save
  end

  test "courdinates should have the `.`" do
    point = Point.new
    point.latitude = '4287793'
    point.longitude = '74.612757'

    assert_not point.save
  end

end
