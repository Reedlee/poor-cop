module Api::V1
  class PointsController < ApiController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def index
      @points = Point.active
      render json: @points, status: :ok
    end

    def new
      @point = Point.new
    end

    def create
      @point = Point.create(point_params)
      if @point.save
        flash[:success] = 'Точка успешно добавлена'
        render json: Point.active, status: :created
      else
        flash[:error] = "Не удалось добавить точку"
        render json: @point.errors, status: 400
      end
    end

    def confirm
      @point = Point.find(params[:id])
      @point.increase_counter
      if @point.save
        flash[:success] = 'Точка успешно подтверждена'
        render json: Point.active, status: :created
      else
        flash[:error] = "Не удалось подтвердить точку"
        render json: @point.errors, status: 404
      end
    end

    def destroy
      @point = Point.find(params[:id])
      @point.deleted_at = Time.now
      if @point.save
        flash[:notice] = 'Точка успешно удалена'
        render json: Point.all, status: :accepted
      else
        flash[:error] = "Не удалось удалить точку"
        render json: @point.errors, status: 500
      end
    end

    private

    def point_params
      params.require(:point).permit(:latitude, :longitude)
    end

    def not_found
      render json: { message: "point: '#{params[:id]}' not found" }, status: 404
    end
  end
end