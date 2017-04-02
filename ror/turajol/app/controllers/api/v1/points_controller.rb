module Api::V1
  class PointsController < ApiController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def index
      @points = Point.active
      respond_to do |format|
        format.json {render json: @points, status: :ok}
      end
    end

    def new
      @point = Point.new
    end

    def create
      @point = Point.create(point_params)
      if @point.save
        flash[:success] = 'Точка успешно добавлена'
        respond_to do |format|
          format.json{render json: Point.active, status: :created}
        end
      else
        flash[:error] = "Не удалось добавить точку"
        respond_to do |format|
          format.json{render json: @point.errors, status: 400}
        end
      end
    end

    def confirm
      @point = Point.find(params[:id])
      @point.increase_counter
      if @point.save
        flash[:success] = 'Точка успешно подтверждена'
        respond_to do |format|
          format.json{render json: Point.active, status: :created}
        end
      else
        flash[:error] = "Не удалось подтвердить точку"
        respond_to do |format|
          format.json{render json: @point.errors, status: 404}
        end
      end
    end

    def destroy
      @point = Point.find(params[:id])
      @point.deleted_at = Time.now
      if @point.save
        flash[:notice] = 'Точка успешно удалена'
        respond_to do|format|
          format.json{render json: Point.all, status: :accepted}
        end
      else
        flash[:error] = "Не удалось удалить точку"
        respond_to do|format|
          format.json{render json: @point.errors, status: 500}
        end
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