class PointsController < ApplicationController
  def index
   @points = Point.all
    respond_to do |format|
      format.html
      format.json {render json: @points.to_json(except: :id)}
    end
  end

  def new
    @point = Point.new
  end

  def create
    p params
    @point = Point.create(point_parameters)
    if @point.save
      redirect_to root_path
    else
      render "new"
    end
  end

  def point_parameters
    params.require(:point).permit(:latitude, :longitude)
  end
end
