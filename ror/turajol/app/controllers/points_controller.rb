class PointsController < ApplicationController
  def index
    @points = Point.active
  end
end
