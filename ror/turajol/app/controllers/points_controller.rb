class PointsController < ApplicationController

  def index
    @points = Point.all
    render plain: @points
  end
end
