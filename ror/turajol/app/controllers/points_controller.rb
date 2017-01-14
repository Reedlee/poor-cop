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
    if @point.save
      respond_to do |format|
        format.html{ redirect_to root_path }
        format.json{ render action: 'index', status: :created  }
      end
    else
      respond_to do |format|
        format.html{ render action: "new" }
        format.json{ render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def point_parameters
    params.require(:point).permit(:latitude, :longitude)
  end
end
