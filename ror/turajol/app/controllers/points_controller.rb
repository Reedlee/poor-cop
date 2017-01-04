class PointsController < ApplicationController
  def index
   @points = Point.all
    respond_to do |format|
      format.html
      format.json {render json: @points.to_json(except: :id)}
    end
  end
end
