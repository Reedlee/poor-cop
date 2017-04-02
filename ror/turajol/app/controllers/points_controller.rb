class PointsController < ApplicationController
  def index
    @points = Point.active
    respond_to do |format|
      format.html
      format.json {render json: @points, status: :ok}
    end
  end
end
