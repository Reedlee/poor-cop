require 'rails_helper'

RSpec.describe Point, type: :model do
  before do
    @point1 = Point.new
    @point2 = Point.new
  end

  context 'check presence' do
    it 'latitude should be presented' do
      @point1.longitude = '74.612757'

      expect(@point1).to_not be_valid
    end

    it 'longitude should be presented' do
      @point1.latitude = '42.87793'

      expect(@point1).to_not be_valid
    end
  end

  context 'check rules of validation' do
    it 'should have two digest before point' do
      @point1.latitude = '42.87793'
      @point1.longitude = '743.612757'

      @point2.latitude = '423.87793'
      @point2.longitude = '74.612757'

      expect(@point1).to_not be_valid and expect(@point2).to_not be_valid
    end

    it 'should consist from integer' do
      @point1.latitude = '42.87k793'
      @point1.longitude = '74.612757'

      @point2.latitude = '42.87793'
      @point2.longitude = '74.6r12757'

      expect(@point1).to_not be_valid and expect(@point2).to_not be_valid
    end

    it "courdinates should have the `.`" do
      @point1.latitude = '4287793'
      @point1.longitude = '74.612757'

      @point2.latitude = '42.87793'
      @point2.longitude = '74612757'

      expect(@point1).to_not be_valid and expect(@point2).to_not be_valid
    end

    it 'should be correct' do
      point = Point.new(longitude: '74.612757', latitude: '42.87793')

      expect(point).to be_valid
    end
  end
end
