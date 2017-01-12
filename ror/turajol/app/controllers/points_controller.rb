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
    @point = Point.create(point_parameters)
  # binding.pry
    if @point.errors.empty?
      render text: params.inspect
      redirect_to point_path(@point)
    else
       render text: "error"
       render "new"
    end
  end

  def point_parameters
    params.require(:point).permit(:latitude, :longitude)
  end
end
