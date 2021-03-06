module Api::V1
  class PointsController < ::Api::ApiController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def index
      points = Point.active
      render json: points, status: :ok
    end

    def new
      @point = Point.new
    end

    def create
      point = Point.create(point_params)
      if @point.save
        render json: Point.active, status: :created
      else
        render json: point.errors, status: 400
      end
    end

    def confirm
      point ||= Point.find(params[:id])
      point.increase_counter
      if point.save
        render json: Point.active, status: :created
      else
        render json: point.errors, status: 404
      end
    end

    private

    def point_params
      params.require(:point).permit(:latitude, :longitude)
    end

    def not_found
      render json: { message: t(:point_find_error, point_id: params[:id]) }, status: 404
    end
  end
end