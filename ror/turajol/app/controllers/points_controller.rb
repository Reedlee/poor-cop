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
        format.json{ render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @point = Point.find(params[:id])
    if @point.destroy
      respond_to do|format|
        format.html{ redirect_to root_path}
        format.json{render action: 'index', status: :deleted}
      end
    else
      respond_to do|format|
        format.html{redirect_to root_path}
        format.json{render json: {message:'cannot delete'}, status: :unprocessable_entity}
      end
    end
  end

  private

  def point_parameters
    params.require(:point).permit(:latitude, :longitude)
  end
end
