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
        flash[:success] = t(:point_add)
        redirect_to root_path
      else
        flash[:error] = t(:point_add_error)
        render action: :new
      end
    end

    def confirm
      @point = Point.find(params[:id])
      @point.increase_counter
      if @point.save
        flash[:success] = t(:point_confirm)
        redirect_to root_path
      else
        flash[:error] = t(:point_confirm_error)
        redirect_to root_path
      end
    end

    def destroy
      @point = Point.find(params[:id])
      @point.deleted_at = Time.now
      if @point.save
        flash[:notice] = t(:point_destroy)
        redirect_to root_path
      else
        flash[:error] = t(:point_destroy_error)
        redirect_to root_path
      end
    end

    private

    def point_params
      params.require(:point).permit(:latitude, :longitude)
    end

    def not_found
      render allert: t(:point_find_error, point_id: params[:id])
    end

  end
end
