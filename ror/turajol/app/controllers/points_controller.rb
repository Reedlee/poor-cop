class PointsController < WebController
  def index
    @points = Point.active
  end
end
