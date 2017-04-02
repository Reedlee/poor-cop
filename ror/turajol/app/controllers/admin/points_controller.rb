module Admin
  class PointsController < AdminController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    def index
      @points = Point.active
    end

    def new
      @point = Point.new
    end

    def create
      @point = Point.create(point_params)
      if @point.save
        flash[:success] = 'Точка успешно добавлена'
        redirect_to root_path
      else
        flash[:error] = "Не удалось добавить точку"
        render action: "new"
      end
    end

    def confirm
      @point = Point.find(params[:id])
      @point.increase_counter
      if @point.save
        flash[:success] = 'Точка успешно подтверждена'
        redirect_to root_path
      else
        flash[:error] = "Не удалось подтвердить точку"
        render redirect_to root_path
      end
    end

    def destroy
      @point = Point.find(params[:id])
      @point.deleted_at = Time.now
      if @point.save
        flash[:notice] = 'Точка успешно удалена'
        redirect_to root_path
      else
        flash[:error] = "Не удалось удалить точку"
        redirect_to root_path, notice: 'not found'
      end
    end

    private

    def point_params
      params.require(:point).permit(:latitude, :longitude)
    end

    def not_found
      render allert: "point: '#{params[:id]}' not found"
    end

  end
end
